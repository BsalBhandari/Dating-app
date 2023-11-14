
import 'package:flutter/material.dart';
import 'package:genix/models/infoprofile.dart';
import 'package:genix/screens/aunthenticate/userinfo2.dart';
import 'package:provider/provider.dart';
import 'package:genix/services/database.dart';

class Userinformation extends StatefulWidget {
  @override
  _UserinformationState createState() => _UserinformationState();
}

class _UserinformationState extends State<Userinformation> {
  String name;
  String email;
  String age;
  String bio;
  String currentSex = 'Male';
  var sex = [
    'Male',
    'Female',
  ];
  String _currentHeight = '4.5-5.0';

  var height = ['4.5-5.0', '5.1-5.6', '5.7-6.5'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _namefield() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }
      },
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget _emailfield() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget _agefield() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Age'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date of Birth is required';
        }
      },
      onSaved: (String value) {
        age = value;
      },
    );
  }

  Widget _biofield() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Bio'),
      validator: (String value) {
        if (value.length >= 255) {
          return 'Bio should be less than 255 characters';
        }
      },
      onSaved: (String value) {
        bio = value;
      },
    );
  }

  Widget _heightfield() {
    return DropdownButton<String>(
        items: height.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
              value: dropDownStringItem, child: Text(dropDownStringItem));
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this._currentHeight = newValueSelected;
          });
        },
        value: _currentHeight);
  }

  Widget _genderfield() {
    return DropdownButton<String>(
      items: sex.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
            value: dropDownStringItem, child: Text(dropDownStringItem));
      }).toList(),
      onChanged: (String newValueSelected) {
        setState(() {
          this.currentSex = newValueSelected;
        });
      },
      value: currentSex,
    );
  }

  Widget _next() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NextUserInfo()));
            _formKey.currentState.save();
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.pink,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<InfoProfile>>.value(
      value: DatabaseService().profileinfo,
        child: Scaffold(
        backgroundColor: Colors.pink[200],
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _namefield(),
                      Container(height: 10.0),
                      _emailfield(),
                      Container(height: 10.0),
                      _agefield(),
                      Container(height: 10.0),
                      _biofield(),
                      Container(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Gender:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 18.0,
                                ),
                              ),
                              Container(
                                width: 10.0,
                              ),
                              _genderfield(),
                            ],
                          ),
                          
                          Column(
                            children: <Widget>[
                              Text(
                                'Height:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  fontSize: 18.0,
                                ),
                              ),
                              _heightfield(),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _next()
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
