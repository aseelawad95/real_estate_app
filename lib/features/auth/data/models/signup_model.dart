// ignore_for_file: public_member_api_docs, sort_constructors_first

class SignupModel {
  final String email;
  final String password;
  final String username;
  final String phoneNumber;
  final String fullName;
  final String street;

  SignupModel({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNumber,
    required this.fullName,
    required this.street
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'username': username,
      'phoneNumber' : phoneNumber,
      'fullName' : fullName,
      'street' : street
    };
  }

}