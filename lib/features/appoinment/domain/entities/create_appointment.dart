class CreateAppointment {
  final DateTime scheduledAt;
  final int propertyId;
  final String customerId;
  final int status;
  final String? notes;

  CreateAppointment({
    required this.scheduledAt,
    required this.propertyId,
    required this.customerId,
    required this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'ScheduledAt': scheduledAt.toIso8601String(),
      'PropertyId': propertyId,
      'CustomerId': customerId,
      'Status': status,
      'Notes': notes,
    };
  }
}