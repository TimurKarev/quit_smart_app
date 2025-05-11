import 'package:equatable/equatable.dart';

enum FailureType {
  unknown,
  noValueInEither,
  firestoreOperationFailure,
  dataMappingFailure,
  authenticationFailure,
  ;

  Failure get failure => Failure(type: this, message: name);
}

class Failure extends Equatable {
  final String message;
  final FailureType type;

  const Failure({
    required this.type,
    required this.message,
  });

  @override
  List<Object?> get props => [
        type,
        message,
      ];
}
