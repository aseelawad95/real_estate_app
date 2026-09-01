abstract class Failure {
  final dynamic message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}