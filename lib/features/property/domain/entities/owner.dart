import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final String name;
  final String? phone;
  final String? ownerId;

  const Owner({
    required this.name,
    this.phone,  this.ownerId,
  });

  @override
  List<Object?> get props => [ownerId,name, phone];
}