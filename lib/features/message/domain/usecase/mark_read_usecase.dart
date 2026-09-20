import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/message/domain/repository/message_repo.dart';
import 'package:real_estate/service_locator.dart';

class MarkAsReadUseCase implements UseCase<Either<Failure, Unit>, int> {
  @override
  Future<Either<Failure, Unit>> call({int? param}) {
    return sl<MessageRepository>().markAsRead(param!);
  }
}