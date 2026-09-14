import 'package:real_estate/features/appoinment/data/models/appointment_customer_model.dart';
import 'package:real_estate/features/appoinment/domain/entities/appointment.dart';
import 'package:real_estate/features/property/data/models/property_model.dart';

class AppointmentModel {
  final int id;
  final DateTime scheduledAt;
  final int status;
  final String? notes;
  final PropertyModel property;
  final AppointmentCustomerModel customer;

  AppointmentModel({
    required this.id,
    required this.scheduledAt,
    required this.status,
    this.notes,
    required this.property,
    required this.customer,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? 0,
      scheduledAt: DateTime.parse(json['scheduledAt']),
      status: json['status'] ?? 0,
      notes: json['notes'],
      property: PropertyModel.fromJson(json['property'] ?? {}),
      customer: AppointmentCustomerModel.fromJson(json['customer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduledAt': scheduledAt.toIso8601String(),
      'status': status,
      'notes': notes,
      'property': property.toJson(),
      'customer': customer.toJson(),
    };
  }

  Appointment toEntity() {
    return Appointment(
      id: id,
      scheduledAt: scheduledAt,
      status: status,
      notes: notes,
      property: property.toEntity(),
      customer: customer.toEntity(),
    );
  }
}