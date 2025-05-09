import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quit_smart_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:quit_smart_app/features/quiz/repository/impl.dart';
import 'package:quit_smart_app/utils/firebase/firestore_service.dart';

class AppDi {
  const AppDi(this.dependencies);

  final Map<Type, Object> dependencies;

  T get<T extends Object>({bool keepAlive = false, bool mock = false}) {
    if (T == FirestoreService) {
      if (dependencies.containsKey(T)) {
        return dependencies[T] as T;
      }

      final service = FirestoreServiceImpl(FirebaseFirestore.instance) as T;
      if (keepAlive) {
        dependencies[T] = service;
      }
      return service;
    } else if (T == QuizRepository) {
      if (dependencies.containsKey(T)) {
        return dependencies[T] as T;
      }

      final repository = QuizRepositoryImpl(
        firestoreService: get<FirestoreService>(keepAlive: true),
      ) as T;
      if (keepAlive) {
        dependencies[T] = repository;
      }
      return repository;
    }
    throw UnimplementedError();
  }
}
