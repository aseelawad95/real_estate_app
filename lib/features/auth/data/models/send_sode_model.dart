// ignore_for_file: public_member_api_docs, sort_constructors_first

class SendCodeModel {
  final String email;

  SendCodeModel({
    required this.email, 
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

}