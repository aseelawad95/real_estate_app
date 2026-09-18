import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static const String _nameIdentifierClaim =
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier';



static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return null;

    try {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken[_nameIdentifierClaim] as String?;
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }
}