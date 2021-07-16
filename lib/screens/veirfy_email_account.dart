import 'package:flutter/material.dart';

class VerifyEmailAccount extends StatelessWidget {
  const VerifyEmailAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text('Verify your email account'),
            ),
          ),
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Go to login page'))
        ],
      ),
    );
  }
}
