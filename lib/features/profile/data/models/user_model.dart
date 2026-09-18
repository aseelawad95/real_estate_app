
import 'package:real_estate/features/profile/domain/entities/user.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final bool? isBlocked;
  final String? role;
  final String? city;
  final String? street;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
     this.isBlocked,
    this.role,
    this.city,
    this.street,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isBlocked: json['isBlocked'] as bool,
      role: json['role'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
    );
  }

  User toEntity() {
    return User(
      id: id,
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
      isBlocked: isBlocked ?? false,
      role: role ?? '',
      city: city,
      street: street ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
    'phoneNumber': phoneNumber,
      'isBlocked': isBlocked,
      'role': role,
      'city': city,
      'street': street,
    };
  }
}