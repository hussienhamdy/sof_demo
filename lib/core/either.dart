import 'package:sof_demo/core/failures.dart';

class Either<T> {
  final T? _value;
  final Failure? _failure;
  Either({T? value, Failure? failure}) : _value = value, _failure = failure;

  T? get value => _value;
  Failure? get failure => _failure;

  Either<T> copyWith({T? value, Failure? failure}) {
    return Either<T>(
      value: value ?? this.value,
      failure: failure ?? this.failure,
    );
  }

  getResult() {
    if (failure != null) {
      return failure;
    } else {
      return value;
    }
  }
}
