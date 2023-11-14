import 'package:flutter/cupertino.dart';

class User{
  final String uid;
  User({this.uid});
}

class UserData{
  String uid;
  String name;
  String age;
  String email;
  String bio;
  String location;
  String currentSex;
  String height;
  String smoke;
  String drink;
  String education;
  String religion;
  String job;
  String prelocation;
  int minage;
  int maxage;
  int distance;
  String pregender;
  String preheight;
  String photoUrl;

  UserData({this.uid , this.name ,this.age,this.email, this.bio, this.location, this.currentSex ,this.height, this.smoke,this.drink,this.education,
  this.religion,this.job, this.prelocation, this.minage, this.maxage, this.distance, this.pregender, this.preheight, this.photoUrl});
}