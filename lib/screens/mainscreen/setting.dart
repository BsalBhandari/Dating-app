import 'package:flutter/material.dart';
import 'package:genix/screens/firstsign/userinfodata.dart';
import 'package:genix/screens/subscreens/mypreference.dart';
import 'package:genix/services/auth.dart';
import 'package:genix/utilis/loading.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool loading = false;

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0,),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(20.0),
              color: Colors.pink[300],
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Datauser()));
                },
                title: Text('User Name' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                
                trailing: Icon(Icons.edit , color: Colors.white,), 
              ),
            ),
            const SizedBox(height: 10.0,),
            Card(
              margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.tag_faces, color: Colors.pink),
                    title: Text('My Preferences'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Preference()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.update, color: Colors.pink,),
                    title: Text('Genix Plus'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add, color: Colors.pink),
                    title: Text('Invite Friends'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock_outline, color: Colors.pink),
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.pink,),
                    title: Text('LogOut'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      setState(() => loading = true);
                      _auth.signOut();
                    },
                  ),
                  SizedBox(height: 60.0,),
                  Text('Powered by BB Enterprise', style: TextStyle(
                    color: Colors.pink[200]
                  ),)
                ],
              ),
            )
          ],
        )
      )
    );
  }
}