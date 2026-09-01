
// ignore_for_file: public_member_api_docs, sort_constructors_first

class VerifyCodeModel {
  final String email;
  final String newPassword;
  final String code;

  VerifyCodeModel({
    required this.email, 
    required this.newPassword,
    required this.code
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': newPassword,
      'code' : code,
    };
  }

}