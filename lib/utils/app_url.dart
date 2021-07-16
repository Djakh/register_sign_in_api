import 'package:http/http.dart' as http;

class AppUrl {
  static const String liveBaseUrl = 'labor.briks.uz';
  static const String localBaseUrl = '10.0.2.2:4000/api/v1';


  static const String baseUrl = liveBaseUrl;
  static var login = Uri.https(baseUrl, 'api/mobile/auth/signin');
  static var register = Uri.https(baseUrl, 'api/mobile/auth/signup');  
  static const String forgotPassword = baseUrl + '/forgot-password';
}