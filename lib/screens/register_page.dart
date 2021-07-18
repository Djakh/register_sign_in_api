import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:register_sign_in_api/model/user.dart';
import 'package:register_sign_in_api/providers/auth_providers.dart';
import 'package:register_sign_in_api/providers/user_provider.dart';
import 'package:register_sign_in_api/utils/validators.dart';
import 'package:register_sign_in_api/utils/widgets.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = new GlobalKey<FormState>();

  late String _name, _userEmail, _password, _confirmPassword;
  late String _regionId;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final userNameField = TextFormField(
      autofocus: false,
      validator: (val) => val!.isEmpty ? "Enter your name" : null,
      onSaved: (value) => _name = value!,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );

    final userEmailField = TextFormField(
      autofocus: false,
      validator: (val) => val!.isEmpty ? "Enter an email" : null,
      onSaved: (value) => _userEmail = value!,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value!.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value!,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value!.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _confirmPassword = value!,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final setRegionId = TextFormField(
      
      autofocus: false,
      validator: (value) =>
          value!.isEmpty ? "Your region id is required" : null,
      onSaved: (value) => _regionId = value!,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.map),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {},
        ),
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          child: Text("Sign in", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        auth
            .register(_name, _userEmail, _password, _confirmPassword, _regionId)
            .then((response) {
          if (response['status']) {
            // User user = response['data'];
            // Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/verify_email_account');
          } else {
            print('response status is not true Djakh');
          }
        });
      } else {
        print('form is not validate Djakh');
      }
    };

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 215.0),
                  label("Name"),
                  SizedBox(height: 5.0),
                  userNameField,
                  SizedBox(height: 15.0),
                  label("Email"),
                  SizedBox(height: 10.0),
                  userEmailField,
                  SizedBox(height: 15.0),
                  label("Password"),
                  SizedBox(height: 10.0),
                  passwordField,
                  SizedBox(height: 15.0),
                  label("Confirm Password"),
                  SizedBox(height: 10.0),
                  confirmPassword,
                  SizedBox(height: 15.0),
                  label("Region id"),
                  SizedBox(height: 10.0),
                  setRegionId,
                  SizedBox(height: 20.0),
                  auth.registeredInStatus == Status.Registering
                      ? loading
                      : longButtons("Register", doRegister),
                  SizedBox(height: 5.0),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
