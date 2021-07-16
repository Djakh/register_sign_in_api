import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_sign_in_api/model/user.dart';
import 'package:register_sign_in_api/providers/user_provider.dart';

class Welcome extends StatelessWidget {
  final User user;

  const Welcome({Key? key,required this.user}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).setUser(user);

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("WELCOME PAGE"),
        ),
      ),
    );
  }
}