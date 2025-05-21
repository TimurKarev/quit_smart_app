import 'package:quit_smart_app/features/auth/domain/models/auth_models.dart';
import 'package:quit_smart_app/utils/data/either.dart';

abstract class AuthRepository {
  Stream<Either<AppUser>> getUser();
  Future<Either<AppUser>> logOut();

  Future<Either<AppUser>> signInWithGoogle();

  Future<Either<AppUser>> signInWithApple();

  Future<Either<AppUser>> signInWithCredentials({
    required String email,
    required String password,
  });
}
