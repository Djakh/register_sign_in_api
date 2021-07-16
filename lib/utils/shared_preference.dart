import 'package:register_sign_in_api/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', user.name!);
    prefs.setString('email', user.email!);
    prefs.setInt('region_id', user.regionId!);
    prefs.setString('token', user.token!);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? regionId = prefs.getInt('region_id');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');

    String? token = prefs.getString('token');

    return User(
      name: name,
      email: email,
      token: token,
      regionId: regionId
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    prefs.remove('email');
prefs.remove('region_id');
    prefs.remove('token');
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }
}
