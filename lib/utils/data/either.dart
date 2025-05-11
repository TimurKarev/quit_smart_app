import 'package:equatable/equatable.dart';
import 'package:quit_smart_app/utils/data/failure.dart';

class Either<T> extends Equatable {
  final T? data;
  final Failure? failure;
  final bool isSuccess;

  const Either._({this.failure, this.data, required this.isSuccess});

  factory Either.success(T data) {
    return Either._(failure: null, data: data, isSuccess: true);
  }

  factory Either.error(Failure failure) {
    return Either._(failure: failure, data: null, isSuccess: false);
  }

  @override
  List<Object?> get props => [failure, data, isSuccess];

  void fold(
    void Function(Failure left) onLeft,
    void Function(T right) onRight,
  ) {
    if (data != null) {
      return onRight(data as T);
    } else {
      return onLeft(failure ?? FailureType.noValueInEither.failure);
    }
  }
}
