import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quit_smart_app/utils/data/failure.dart';

abstract class FirestoreService {
  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data) mapper,
  });

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data) mapper,
  });
}

class FirestoreServiceImpl implements FirestoreService {
  FirestoreServiceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data) mapper,
  }) async {
    try {
      final DocumentReference<Map<String, dynamic>> documentReference =
          _firestore.doc(path);
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await documentReference.get();

      if (documentSnapshot.exists) {
        final Map<String, dynamic>? data = documentSnapshot.data();
        if (data != null) {
          return mapper(data);
        } else {
          throw Failure(
            type: FailureType.firestoreOperationFailure,
            message: 'Document at path: $path exists but contains no data.',
          );
        }
      } else {
        throw Failure(
          type: FailureType.firestoreOperationFailure,
          message: 'Document not found at path: $path',
        );
      }
    } on FirebaseException catch (e) {
      throw Failure(
        type: FailureType.firestoreOperationFailure,
        message: 'Firestore error for document $path: ${e.message}',
      );
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure(
        type: FailureType.unknown,
        message: 'Unexpected error fetching document $path: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data) mapper,
  }) async {
    final QuerySnapshot<Map<String, dynamic>>? querySnapshot;
    try {
      querySnapshot = await _firestore.collection(path).get();
    } on FirebaseException catch (e) {
      throw Failure(
        type: FailureType.firestoreOperationFailure,
        message: 'Firestore error for collection $path: ${e.message}',
      );
    }

    return querySnapshot.docs
        .where((doc) => doc.exists)
        .map((doc) => mapper(doc.data()))
        .toList();
  }
}
