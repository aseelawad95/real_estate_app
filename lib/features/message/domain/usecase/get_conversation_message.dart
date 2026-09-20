import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/message/domain/entities/message_entity.dart';
import 'package:real_estate/features/message/domain/repository/message_repo.dart';
import 'package:real_estate/service_locator.dart';

class GetConversationMessagesUseCase
    implements UseCase<Either<Failure, List<MessageEntity>>, int> {
  @override
  Future<Either<Failure, List<MessageEntity>>> call({int? param}) {
    return sl<MessageRepository>().getConversationMessages(param!);
  }
}