// lib/features/messages/data/repository/message_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:real_estate/core/errors/server_failure.dart';
import 'package:real_estate/features/message/data/models/send_message_model.dart';
import 'package:real_estate/features/message/data/source/message_api_service.dart';
import 'package:real_estate/features/message/domain/entities/conversation_entity.dart';
import 'package:real_estate/features/message/domain/entities/message_entity.dart';
import 'package:real_estate/features/message/domain/entities/send_message.dart';
import 'package:real_estate/features/message/domain/repository/message_repo.dart';


class MessageRepositoryImpl extends MessageRepository {
  final MessageApiService apiService;
  MessageRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(SendMessageParams params) async {
    final requestModel = SendMessageRequestModel.fromParams(params);
    final result = await apiService.sendMessage(requestModel);
    return result.map((model) => model.toEntity());
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    final result = await apiService.getConversations();
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getConversationMessages(
      int conversationId) async {
    final result = await apiService.getConversationMessages(conversationId);
    return result.map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, Unit>> markAsRead(int conversationId) {
    return apiService.markAsRead(conversationId);
  }

  @override
  Future<Either<Failure, int?>> findConversationId({
    required int propertyId,
    required String otherUserId,
  }) async {
    final result = await apiService.getConversations();
    return result.map<int?>((models) {
      for (final c in models) {
        if (c.propertyId == propertyId && c.otherUserId == otherUserId) {
          return c.id;
        }
      }
      return null;
    });
  }
}