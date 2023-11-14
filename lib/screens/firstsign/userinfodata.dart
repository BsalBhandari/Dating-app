import 'package:flutter/material.dart';
import 'package:genix/screens/firstsign/profilepic.dart';
import 'package:genix/screens/mainscreen/Home.dart';
import 'package:genix/screens/mainscreen/profile.dart';
import 'package:provider/provider.dart';
import 'package:genix/services/database.dart';
import 'package:genix/models/users.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Datauser extends StatefulWidget {
  @override
  _DatauserState createState() => _DatauserState();
}

class _DatauserState extends State<Datauser> {
  
  String _username;
  String _userdob;
  String _useremail;
  String _userLocation;
  String userage;
  bool agelevel;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    final _namekey = GlobalKey<FormState>();
    final _emaikey = GlobalKey<FormState>();
    final _lockey = GlobalKey<FormState>();
    final user = Provider.of<User>(context);
    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  color: Colors.pink,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    Card(
                      elevation: 0.0,
                      margin: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                            textScaleFactor: 1.2,
                          ),
                          TextFormField(
                            initialValue: userData.name,
                            key: _namekey,
                            decoration: InputDecoration(hintText: 'Name'),
                            validator: (String name) {
                              if (name.isEmpty) {
                                return 'Name is mandatory';
                              }
                            },
                            onChanged: (String name) {
                              _username = name;
                            },
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 0.0,
                      margin: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            'yy-mm-dd',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DateTimeField(
                            format: format,
                            initialValue: DateTime.now(),
                            onShowPicker: (context, currentvalue) {
                              return showDatePicker(
                                  context: context,
                                  initialDate: currentvalue ?? DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100));
                            },
                            onChanged: (userdate) {
                              if (DateTime.now().year - userdate.year >= 16) {
                                _userdob = userdate.toString();
                                setState(() {
                                  agelevel = true;
                                  int age =DateTime.now().year - userdate.year;
                                  userage = age.toString();
                                });
                              } else {
                                setState(() {
                                  agelevel = false;
                                });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                      child: Text(
                        '$_userdob',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      elevation: 0.0,
                      margin: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Email Address',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                            textScaleFactor: 1.4,
                          ),
                          TextFormField(
                            initialValue: userData.email,
                            key: _emaikey,
                            decoration: InputDecoration(labelText: 'Email'),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Email is mandatory';
                              }
                            },
                            onChanged: (String usermail) {
                              _useremail = usermail;
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Card(
                      elevation: 0.0,
                      margin: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                            textScaleFactor: 1.4,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            initialValue: userData.location,
                            key: _lockey,
                            decoration: InputDecoration(labelText: 'location'),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Location is mandatory';
                              }
                            },
                            onChanged: (String userloc) {
                              _userLocation = userloc;
                            },
                          )
                        ],
                      ),
                    ),
                    Card(
                      elevation: 0.0,
                      margin: EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(width: 10),
                          IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.pink,
                              ),
                              onPressed: () async {
                                
                                  await DatabaseService(uid: user.uid)
                                      .updateUserInfo(
                                          _username ?? userData.name,
                                          userage ?? userData.age,
                                          _useremail ?? userData.email,
                                          userData.bio,
                                          _userLocation ?? userData.location,
                                          userData.currentSex,
                                          userData.height,
                                          userData.smoke,
                                          userData.drink,
                                          userData.religion,
                                          userData.job,
                                          userData.education,
                                          userData.prelocation,
                                          userData.minage,
                                          userData.maxage,
                                          userData.distance,
                                          userData.pregender,
                                          userData.preheight,
                                          userData.photoUrl);
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectProfilePic()));
                                
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
