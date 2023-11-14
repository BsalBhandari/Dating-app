import 'package:flutter/material.dart';
import 'package:genix/screens/mainscreen/Home.dart';
import 'package:genix/utilis/loading.dart';
import 'package:provider/provider.dart';
import 'package:genix/services/database.dart';
import 'package:genix/models/users.dart';

class Preference extends StatefulWidget {
  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  String _location;
  String gender;
  
  int _currentdistance;
  String _currentpreSex;
  final List<String> _sex = [
    'Male',
    'Female',
  ];

  String _preHeight;

  final List<String> oheight = ['4.5-5.0 ft', '5.1-5.6 ft', '5.7-6.5 ft'];

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            double _minvalue = 16.0;
            double _maxvalue = 100.0;
            RangeValues _values = RangeValues(userData.minage.toDouble() , userData.maxage.toDouble() );
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: Center(
                    child: Text(
                      'Preference',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
                          await DatabaseService(uid: user.uid).updateUserInfo(
                              userData.name,
                              userData.age,
                              userData.email,
                              userData.bio,
                              userData.location,
                              gender ?? userData.currentSex,
                              userData.height,
                              userData.smoke,
                              userData.drink,
                              userData.religion,
                              userData.job,
                              userData.education,
                              _location ?? userData.prelocation,
                              _values.start.toInt() ?? userData.minage,
                              _values.end.toInt() ?? userData.maxage,
                              _currentdistance ?? userData.distance,
                              _currentpreSex ?? userData.pregender,
                              _preHeight ?? userData.preheight,
                              userData.photoUrl);

                          return Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }),
                  ]),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.00,
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'Location',
                                  style: TextStyle(
                                      color: Colors.pink[200],
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.2,
                                ),
                              ),
                              Container(
                                width: 105.0,
                              ),
                              Expanded(
                                  child: TextFormField(
                                key: _formkey,
                                initialValue: userData.prelocation,
                                decoration:
                                    InputDecoration(labelText: 'Location'),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'This field is Empty';
                                  }
                                },
                                onChanged: (String value) {
                                  _location = value;
                                },
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12.0, right: 13.0),
                            alignment: Alignment.bottomLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Age',
                                      style: TextStyle(
                                          color: Colors.pink[200],
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    '${_values.start} - ${_values.end} yrs',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.0,
                                  )
                                ]),
                          ),
                          RangeSlider(
                              activeColor: Colors.pink[300],
                              inactiveColor: Colors.black54,
                              min: (_minvalue ?? userData.minage).toDouble(),
                              max: (_maxvalue ?? userData.maxage).toDouble(),
                              divisions: 84,
                              values: _values,
                              onChanged: (val) {
                                setState(() {
                                  _values = val;
                                });
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12.0, right: 12.0),
                            alignment: Alignment.bottomLeft,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Distance(Km)',
                                    style: TextStyle(
                                        color: Colors.pink[200],
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.2,
                                  ),
                                  Text(
                                    '0 - ${_currentdistance ?? userData.distance} km',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textScaleFactor: 1.0,
                                  )
                                ]),
                          ),
                          Slider(
                              activeColor: Colors.pink[300],
                              inactiveColor: Colors.black54,
                              min: 1.0,
                              max: 100.0,
                              divisions: 99,
                              value: (_currentdistance ?? userData.distance)
                                  .toDouble(),
                              onChanged: (val) {
                                setState(() {
                                  _currentdistance = val.round();
                                });
                              }),
                          SizedBox(height: 10.0),
                          Card(
                            elevation: 0.0,
                            margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                      color: Colors.pink[200],
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.2,
                                ),
                                Container(
                                  width: 150,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                      value:
                                          userData.pregender ?? _currentpreSex,
                                      items: _sex.map((_userpresex) {
                                        return DropdownMenuItem(
                                            value: _userpresex,
                                            child: Text('$_userpresex'));
                                      }).toList(),
                                      onChanged: (usersexval) {
                                        setState(() {
                                          _currentpreSex = usersexval;
                                          if(_currentpreSex == 'Male' ){
                                            gender = 'Female';
                                          }else {
                                            gender = 'Male';
                                          }
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            elevation: 0.0,
                            margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Height',
                                  style: TextStyle(
                                      color: Colors.pink[200],
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1.2,
                                ),
                                Container(
                                  width: 150,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField(
                                      value: _preHeight ?? userData.preheight,
                                      items: oheight.map((_userpreheight) {
                                        return DropdownMenuItem(
                                            value: _userpreheight,
                                            child: Text('$_userpreheight'));
                                      }).toList(),
                                      onChanged: (userpreheight) {
                                        setState(() {
                                          _preHeight = userpreheight;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
