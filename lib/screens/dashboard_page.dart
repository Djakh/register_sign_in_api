import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:register_sign_in_api/model/user.dart';
import 'package:register_sign_in_api/providers/user_provider.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD PAGE"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Center(child: Text(user.email ?? 'it is null')),
          SizedBox(height: 100),
          RaisedButton(onPressed: (){}, child: Text("Logout"), color: Colors.lightBlueAccent,)
        ],
      ),
    );
  }
}