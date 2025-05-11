import 'package:equatable/equatable.dart' show Equatable;

sealed class AppUser extends Equatable {
  const AppUser();

  @override
  List<Object> get props => [];
}

class AuthenticatedUser extends AppUser {
  const AuthenticatedUser({required this.uid});

  final String uid;
}

class UnauthenticatedUser extends AppUser {
  const UnauthenticatedUser();
}
