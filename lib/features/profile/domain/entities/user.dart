class User {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final bool isBlocked;
  final String? role;
  final String? city;
  final String? street;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.isBlocked,
     this.role,
    this.city,
     this.street,
  });
}