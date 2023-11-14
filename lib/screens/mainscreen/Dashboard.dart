import 'package:flutter/material.dart';
import 'package:genix/screens/aunthenticate/userinfo2.dart';
import 'package:genix/screens/mainscreen/setting.dart';
import 'package:genix/screens/subscreens/mypreference.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.tag_faces, color: Colors.pink),
        onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context)=> Preference()));
        }),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      
    );
  }
}