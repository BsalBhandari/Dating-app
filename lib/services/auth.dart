import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:genix/screens/aunthenticate/aunthenticate.dart';
import 'package:genix/screens/mainscreen/Home.dart';
import 'package:genix/services/database.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert' as JSON ;
import 'package:genix/models/users.dart';
import 'package:provider/provider.dart';



class AuthService {
  User _userfromfirebaseuser(FirebaseUser user){
      return user != null ? User(uid: user.uid) : null ;
  }
  
  Stream <User> get user{
    return _auth.onAuthStateChanged.map(_userfromfirebaseuser);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  FirebaseUser myuser;

  Future<FirebaseUser> _loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    FacebookLoginResult result = await facebookLogin.logIn(['email']);
    final FacebookAccessToken accessToken = result.accessToken; 
    AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.token);
    if (result.status == FacebookLoginStatus.loggedIn) {
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserInfo( 'name','age', 'email' , 'bio',
      'location',  'Female', '4.5-5.0', 'Never', 'Never', 'Hindu', '' , 'High School', 'location',
      16 , 100 , 20 , 'Male' ,'4.5-5.0 ft' , 'https://www.booksie.com/files/profiles/22/mr-anonymous_230x230.png');
      return user;
    }
    return null;
  }

  Future signinwithEmailandpw(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromfirebaseuser(user);
    }catch(e){
      print(e.toString());
    }
  }

  Future registerwithEmailandpw(String email, String password) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create document for new user
      await DatabaseService(uid:user.uid).updateUserInfo('name','age', 'email' , 'bio',
      'location',  'Female', '4.5-5.0', 'Never', 'Never', 'Hindu', '' , 'High School', 'location',
      16 , 100 , 20 , 'Male' ,'4.5-5.0 ft' , 'https://www.booksie.com/files/profiles/22/mr-anonymous_230x230.png');
      return _userfromfirebaseuser(user);
    }catch(e){
      print(e.toString());
    }
  }

  Future logIn(){
    _loginWithFacebook().then((user) {
      if (user!= null){
        myuser = user;
        return _userfromfirebaseuser(myuser);
      }
    });
  }

  Future signOut() async{
    return await _auth.signOut();
  }

}
