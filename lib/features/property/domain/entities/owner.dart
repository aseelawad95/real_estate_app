import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final String name;
  final String? phone;

  const Owner({
    required this.name,
    this.phone,
  });

  @override
  List<Object?> get props => [name, phone];
}