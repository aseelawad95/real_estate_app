class AppointmentCustomer {
  final String id;
  final String fullName;
  final String? phone;

  AppointmentCustomer({
    required this.id,
    required this.fullName,
    this.phone,
  });
}