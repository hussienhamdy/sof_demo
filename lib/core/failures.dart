sealed class Failure {}

class NetworkFailure extends Failure {}

class FailureWithMessage extends Failure {
  final String message;
  FailureWithMessage({required this.message});
}

class GeneralFailure extends Failure {}
