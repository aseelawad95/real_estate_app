import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/core/usecase/usecase.dart';
import 'package:real_estate/features/message/domain/entities/conversation_entity.dart';
import 'package:real_estate/features/message/domain/repository/message_repo.dart';
import 'package:real_estate/service_locator.dart';

class GetConversationsUseCase
    implements UseCase<Either<Failure, List<ConversationEntity>>, dynamic> {
  @override
  Future<Either<Failure, List<ConversationEntity>>> call({dynamic param}) {
    return sl<MessageRepository>().getConversations();
  }
}