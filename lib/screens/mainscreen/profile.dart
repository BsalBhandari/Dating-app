import 'package:flutter/material.dart';
import 'package:genix/models/users.dart';
import 'package:genix/screens/mainscreen/Dashboard.dart';
import 'package:genix/screens/mainscreen/Home.dart';
import 'package:genix/utilis/loading.dart';
import 'package:provider/provider.dart';
import 'package:genix/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _bio;
  String _job;
  String _religion;
  String _smoke;
  String _drink;
  String _education;
  String _currentHeight ;
  final List<String> _userReligion = [
    'Hindu',
    'Buddhist',
    'Christain',
    'Muslim',
    'Others'
  ];
  String _currentSex ;
  final List<String> _usersex = [
    'Male',
    'Female',
  ];
  final List<String> _routSmoke = ['Never', 'Sometimes', 'Frequently'];
  final List<String> _routDrink = ['Never', 'Sometimes', 'Frequently'];
  final List<String> _usereducation = [
    'High School',
    'Under graduation',
    'Post Graduation'
  ];
  final List<String> height = ['4.5-5.0', '5.1-5.6', '5.7-6.5'];
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  actions: <Widget>[
                    Center(
                      child: Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.pink,
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserInfo(
                                userData.name,
                                userData.age,
                                userData.email,
                                _bio ?? userData.bio,
                                userData.location,
                                _currentSex ?? userData.currentSex,
                                _currentHeight ?? userData.height,
                                _smoke ?? userData.smoke,
                                _drink ?? userData.drink,
                                _religion ?? userData.religion,
                                _job ?? userData.job,
                                _education ?? userData.education,
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
                                    builder: (context) => Home()));
                          }
                        }),
                  ]),
              backgroundColor: Colors.white,
              body: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.fromLTRB(33.0, 20.0, 10.0, 5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Container(
                          height: 100.0,
                          child: Image(image: NetworkImage(userData.photoUrl)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 20.0,
                          ),
                          Text(
                            userData.name,
                            textScaleFactor: 1.2,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ', ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            userData.age,
                            textScaleFactor: 1.2,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Gender',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Container(
                              width: 170.0,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value:   _currentSex ?? 'Male',
                                  items: _usersex.map((_usersex) {
                                    return DropdownMenuItem(
                                        value: _usersex,
                                        child: Text('$_usersex'));
                                  }).toList(),
                                  onChanged: (usersexval) {
                                    setState(() {
                                      _currentSex = usersexval;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Text(
                              userData.email,
                              textScaleFactor: 1.2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Location',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Text(
                              userData.location,
                              textScaleFactor: 1.2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 22.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        alignment: Alignment.topLeft,
                        child: Text('About You',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w900)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                        child: TextFormField(
                          initialValue: userData.bio,
                          decoration: InputDecoration(labelText: 'Bio'),
                          validator: (String biovalue) {
                            if (biovalue.length >= 255) {
                              return 'Bio should be less than 255 characters';
                            }
                          },
                          onChanged: (String biovalue) {
                            _bio = biovalue;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                        child: TextFormField(
                          initialValue: userData.job,
                          decoration: InputDecoration(hintText: 'Job'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'This field is Empty';
                            }
                          },
                          onChanged: (String jobvalue) {
                            _job = jobvalue;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Height',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Container(
                              width: 140.0,
                            ),
                             Expanded(
                              child: DropdownButtonFormField(
                                  value:  _currentHeight ?? '4.5-5.0' ,
                                  items: height.map((_userheight) {
                                    return DropdownMenuItem(
                                        value:  _userheight,
                                        child: Text('$_userheight ft'));
                                  }).toList(),                        
                                  onChanged: (heightval) {
                                    setState(() {
                                      _currentHeight = heightval;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Education',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Container(
                              width: 90.0,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value: _education ?? 'High School' ,
                                  items: _usereducation.map((_useredu) {
                                    return DropdownMenuItem(
                                        value: _useredu,
                                        child: Text('$_useredu'));
                                  }).toList(),
                                  onChanged: (usereduval) {
                                    setState(() {
                                      _education = usereduval;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Religion',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Container(
                              width: 100.0,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value: _religion ?? 'Hindu' , 
                                  items: _userReligion.map((_userreg) {
                                    return DropdownMenuItem(
                                        value: _userreg,
                                        child: Text('$_userreg'));
                                  }).toList(),
                                  onChanged: (userregval) {
                                    setState(() {
                                      _religion = userregval;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Smoking',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Container(
                              width: 90.0,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value:  _smoke ?? 'Never' ,
                                  items: _routSmoke.map((_usersmoke) {
                                    return DropdownMenuItem(
                                        value: _usersmoke,
                                        child: Text('$_usersmoke'));
                                  }).toList(),
                                  onChanged: (smokeval) {
                                    setState(() {
                                      _smoke = smokeval;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Card(
                        elevation: 0.0,
                        margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Drink',
                              style: TextStyle(
                                  color: Colors.brown[200],
                                  fontWeight: FontWeight.w800),
                              textScaleFactor: 1.1,
                            ),
                            Container(
                              width: 110.0,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                  value: _drink ?? 'Never' ,
                                  items: _routDrink.map((_userDrink) {
                                    return DropdownMenuItem(
                                        value: _userDrink,
                                        child: Text('$_userDrink'));
                                  }).toList(),
                                  onChanged: (drinkval) {
                                    setState(() {
                                      _drink = drinkval;
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      )
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Loading();
          }
        });
  }
}
