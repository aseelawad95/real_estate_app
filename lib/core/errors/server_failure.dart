abstract class Failure {
  final dynamic message;
  Failure(this.message);

  @override
  String toString() => message?.toString() ?? 'Unknown error';
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}