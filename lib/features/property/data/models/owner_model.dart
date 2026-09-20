import 'package:real_estate/features/property/domain/entities/owner.dart';

class OwnerModel {
  final String? ownerId;
  final String name;
  final String? phone;

  OwnerModel({
    required this.name,
    this.phone, this.ownerId,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      ownerId : json['ownerId'],
      name: json['ownerName'] ?? '',
      phone: json['ownerPhone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerName': name,
      'ownerPhone': phone,
      'ownerId' :ownerId
    };
  }

  Owner toEntity() {
    return Owner(
      name: name,
      phone: phone,
      ownerId: ownerId
    );
  }
}