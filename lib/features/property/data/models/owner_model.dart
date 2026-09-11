import 'package:real_estate/features/property/domain/entities/owner.dart';

class OwnerModel {
  final String name;
  final String? phone;

  OwnerModel({
    required this.name,
    this.phone,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      name: json['ownerName'] ?? '',
      phone: json['ownerPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerName': name,
      'ownerPhone': phone,
    };
  }

  Owner toEntity() {
    return Owner(
      name: name,
      phone: phone,
    );
  }
}