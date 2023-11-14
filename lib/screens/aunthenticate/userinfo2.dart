import 'package:flutter/material.dart';

class NextUserInfo extends StatefulWidget {
  @override
  _NextUserInfoState createState() => _NextUserInfoState();
}

class _NextUserInfoState extends State<NextUserInfo> {
  String _smoke = 'Never';
  var _routSmoke = ['Never', 'Sometimes', 'Frequently'];
  String _drink = 'Never';
  var _routDrink = ['Never', 'Sometimes', 'Frequently'];
  String _ogender = 'Male';
  var _pregender = ['Male', 'Female'];
  String _religion = 'Hindu';
  var _userReligion = ['Hindu', 'Buddhist', 'Christain', 'Muslim', 'Others'];
  String _job;
  String _education = 'High School';
  var _usereducation = ['High School', 'Uuder graduation', 'Post Graduation'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _smokefield() {
    return DropdownButton<String>(
        items: _routSmoke.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
              value: dropDownStringItem, child: Text(dropDownStringItem));
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this._smoke = newValueSelected;
          });
        },
        value: _smoke);
  }

  Widget _drinkfield() {
    return DropdownButton<String>(
        items: _routDrink.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
              value: dropDownStringItem, child: Text(dropDownStringItem));
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this._drink = newValueSelected;
          });
        },
        value: _drink);
  }

  Widget _oppgender() {
    return DropdownButton<String>(
      items: _pregender.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
            value: dropDownStringItem, child: Text(dropDownStringItem));
      }).toList(),
      onChanged: (String newValueSelected) {
        setState(() {
          this._ogender = newValueSelected;
        });
      },
      value: _ogender,
    );
  }

  Widget _religionfield() {
    return DropdownButton<String>(
      items: _userReligion.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
            value: dropDownStringItem, child: Text(dropDownStringItem));
      }).toList(),
      onChanged: (String newValueSelected) {
        setState(() {
          this._religion = newValueSelected;
        });
      },
      value: _religion,
    );
  }

  Widget _userjob() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: 'Job'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'This field is empty';
        }
      },
      onSaved: (String value) {
        _job = value;
      },
    );
  }

  Widget _useredu() {
    return DropdownButton<String>(
      items: _usereducation.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
            value: dropDownStringItem, child: Text(dropDownStringItem));
      }).toList(),
      onChanged: (String newValueSelected) {
        setState(() {
          this._education = newValueSelected;
        });
      },
      value: _education,
    );
  }

  Widget _next() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
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
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(25.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Smoking',
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
                            _smokefield(),
                          ],
                        ),
                        
                        Column(
                          children: <Widget>[
                            Text(
                              'Drinking',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                                fontSize: 18.0,
                              ),
                            ),
                            _drinkfield(),
                          ],
                        )
                      ],
                    ),
                    Container(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Prefered Gender',
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
                            _oppgender(),
                          ],
                        ),
                        
                        Column(
                          children: <Widget>[
                            Text(
                              'Your Religion',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                                fontSize: 18.0,
                              ),
                            ),
                            _religionfield(),
                          ],
                        )
                      ],
                    ),
                    Container(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Your Education',
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
                            _useredu(),
                          ],
                        ),
                      ],
                    ),
                    Container(height: 20.0,),
                    _userjob(),
                    _next(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
