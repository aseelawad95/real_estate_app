class SendMessageParams {
  final int? conversationId;
  final String? receiverId;
  final int? propertyId;
  final String content;

  const SendMessageParams({
    required this.content,
    this.conversationId,
    this.receiverId,
    this.propertyId,
  });
}