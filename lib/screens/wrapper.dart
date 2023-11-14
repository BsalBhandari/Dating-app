import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genix/models/users.dart';
import 'package:genix/screens/aunthenticate/aunthenticate.dart';
import 'package:genix/screens/aunthenticate/login_screen.dart';
import 'package:genix/screens/mainscreen/Dashboard.dart';
import 'package:genix/screens/mainscreen/Home.dart';
import 'package:genix/screens/mainscreen/setting.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}