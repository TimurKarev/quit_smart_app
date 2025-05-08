import 'package:cloud_firestore/cloud_firestore.dart';

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
    final DocumentReference<Map<String, dynamic>> documentReference = _firestore.doc(path);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      final Map<String, dynamic>? data = documentSnapshot.data();
      if (data != null) {
        return mapper(data);
      } else {
        // Document exists, but contains no data.
        throw FirebaseException(
          plugin: 'FirestoreService',
          message: 'Document at path: $path exists but contains no data.',
        );
      }
    } else {
      // Document does not exist.
      throw FirebaseException(
        plugin: 'FirestoreService',
        message: 'Document not found at path: $path',
      );
    }
  }

  @override
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data) mapper,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection(path).get();
    return querySnapshot.docs
        .where((doc) => doc.exists)
        .map((doc) => mapper(doc.data()))
        .toList();
  }
}
