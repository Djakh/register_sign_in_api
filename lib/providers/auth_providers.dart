import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:register_sign_in_api/model/user.dart';
import 'package:register_sign_in_api/utils/app_url.dart';
import 'package:register_sign_in_api/utils/shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  static Future<Map<String, String>> getAuthorization() async {
    final token = await UserPreferences().getToken();
    return {'Authorization': "Bearer $token"};
  }

  static Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    // Set token.
    headers.addAll(await getAuthorization());

    return headers;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    final client = http.Client();
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await client.post(
        Uri.https('labor.briks.uz', 'api/mobile/auth/signin'),
        body: json.encode(loginData),
        headers: {
          'Content-Type': 'application/json',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('some issue');
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(String name, String email,
      String password, String passwordConfirmation, String regionId) async {
    var result;
    final headers = await getHeaders();
    var myRegionId = int.parse(regionId);
    assert(myRegionId is int);

    final Map<String, dynamic> registrationData = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'region_id': myRegionId
    };

    var response = await http.post(
        Uri.https('labor.briks.uz', 'api/mobile/auth/signup'),
        body: json.encode(registrationData),
        headers: headers);

    print("response status is ${response.statusCode}");

    _registeredInStatus = Status.Registering;
    notifyListeners();

    print(response.statusCode);
    if (response.statusCode == 200) {
      setDataFromResponse(response);
      result = {
        'status': true,
        'message': 'Successfully registered',
        //'data': authUser
      };
    } else {
      print(response.statusCode);
      _registeredInStatus = Status.NotRegistered;
      result = {
        'status': false,
        'message': 'Registration failed',
        // 'data': responseData
      };
    }

    return result;
  }

  void setDataFromResponse(Response response) async {
    var responseData = await json.decode(response.body);
    //var userData = await responseData['data'];

    User authUser = User.fromJson(responseData);

    UserPreferences().saveUser(authUser);
  }

  // static onError(error) {
  //   print("the error is $error.detail");
  //   return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  // }
}
