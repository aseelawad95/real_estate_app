import 'package:real_estate/features/appoinment/domain/entities/appointment_customer.dart';
import 'package:real_estate/features/property/domain/entities/property.dart';

class Appointment {
  final int id;
  final DateTime scheduledAt;
  final int status;
  final String? notes;
  final Property property;
  final AppointmentCustomer customer;

  Appointment({
    required this.id,
    required this.scheduledAt,
    required this.status,
    this.notes,
    required this.property,
    required this.customer,
  });
}