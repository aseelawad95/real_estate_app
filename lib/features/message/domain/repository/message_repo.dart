import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/message/domain/entities/conversation_entity.dart';
import 'package:real_estate/features/message/domain/entities/message_entity.dart';
import 'package:real_estate/features/message/domain/entities/send_message.dart';

abstract class MessageRepository {
  Future<Either<Failure, MessageEntity>> sendMessage(SendMessageParams params);
  Future<Either<Failure, List<ConversationEntity>>> getConversations();
  Future<Either<Failure, List<MessageEntity>>> getConversationMessages(int conversationId);
  Future<Either<Failure, Unit>> markAsRead(int conversationId);
  Future<Either<Failure, int?>> findConversationId({
    required int propertyId,
    required String otherUserId,
  });
}