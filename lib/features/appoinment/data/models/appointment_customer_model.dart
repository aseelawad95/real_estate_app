import 'package:real_estate/features/appoinment/domain/entities/appointment_customer.dart';

class AppointmentCustomerModel {
  final String id;
  final String fullName;
  final String? phone;

  AppointmentCustomerModel({
    required this.id,
    required this.fullName,
    this.phone,
  });

  factory AppointmentCustomerModel.fromJson(Map<String, dynamic> json) {
    return AppointmentCustomerModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
    };
  }

  AppointmentCustomer toEntity() {
    return AppointmentCustomer(
      id: id,
      fullName: fullName,
      phone: phone,
    );
  }
}