import 'package:real_estate/features/message/domain/entities/send_message.dart';

class SendMessageRequestModel {
  final int? conversationId;
  final String? receiverId;
  final int? propertyId;
  final String content;

  SendMessageRequestModel({
    required this.content,
    this.conversationId,
    this.receiverId,
    this.propertyId,
  });

  factory SendMessageRequestModel.fromParams(SendMessageParams params) {
    return SendMessageRequestModel(
      conversationId: params.conversationId,
      receiverId: params.receiverId,
      propertyId: params.propertyId,
      content: params.content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (conversationId != null) 'conversationId': conversationId,
      if (receiverId != null) 'receiverId': receiverId,
      if (propertyId != null) 'propertyId': propertyId,
      'content': content,
    };
  }
}