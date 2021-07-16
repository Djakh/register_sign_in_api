
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_sign_in_api/providers/auth_providers.dart';
import 'package:register_sign_in_api/providers/user_provider.dart';
import 'package:register_sign_in_api/screens/register_page.dart';
import 'package:register_sign_in_api/screens/veirfy_email_account.dart';
import 'package:register_sign_in_api/screens/welcome.dart';
import 'package:register_sign_in_api/utils/shared_preference.dart';

import 'model/user.dart';
import 'screens/dashboard_page.dart';
import 'screens/log_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreferences().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data.token == null)
                      return Login();
                    else
                      UserPreferences().removeUser();
                    return Welcome(user: snapshot.data);
                }
              }),
          routes: {
            '/dashboard': (context) => DashBoardPage(),
            '/login': (context) => Login(),
            '/register': (context) => RegisterPage(),
            '/verify_email_account': (context) => VerifyEmailAccount(),
          }),
    );
  }
}
