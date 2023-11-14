import 'package:flutter/material.dart';
import 'package:genix/models/users.dart';
import 'package:genix/screens/wrapper.dart';
import 'package:genix/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Genix',
        theme: ThemeData(
        ),
        home: Wrapper(),
        ),
    );
      }
      }