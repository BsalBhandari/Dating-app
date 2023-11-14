import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:genix/models/infoprofile.dart';
import 'package:genix/models/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('Genix');


  Future updateUserInfo(
      String name,
      String age,
      String email,
      String bio,
      String location,
      String currentsex,
      String height,
      String smoke,
      String drink,
      String religion,
      String job,
      String education,
      String prelocation,
      int minage,
      int maxage,
      int distance,
      String pregender,
      String preheight,
      String photoUrl) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'age': age,
      'email': email,
      'bio': bio,
      'location': location,
      'currentsex': currentsex,
      'height': height,
      'smoke': smoke,
      'drink': drink,
      'religion': religion,
      'job': job,
      'education': education,
      'prelocation': prelocation,
      'minage': minage,
      'maxage': maxage,
      'distance': distance,
      'pregender': pregender,
      'preheight': preheight,
      'photoUrl' : photoUrl
    });
  }


  Future updateProfilePic(picUrl) async {
    var UserInfo = new UserData();
    UserInfo.photoUrl = picUrl;
    await FirebaseAuth.instance
        .currentUser()
        .then((user) => {
              Firestore.instance
                  .collection('Genix')
                  .where('uid', isEqualTo: user.uid)
                  .getDocuments()
                  .then((doc) {
                Firestore.instance
                    .document('/Genix/${doc.documents[0].documentID}')
                    .updateData({'photoUrl': picUrl})
                    .then((value) => print('Updated'))
                    .catchError((e) {
                      print(e);
                    });
              })
            })
        .catchError((e) => print(e));
  }

  UserData _userdatafromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      name: snapshot.data['name'] ?? '',
      age: snapshot.data['age'] ?? '',
      email: snapshot.data['email'] ?? '',
      bio: snapshot.data['bio'] ?? '',
      location: snapshot.data['location'] ?? '',
      currentSex: snapshot.data['currentSex'] ?? '',
      height: snapshot.data['height'] ?? '',
      smoke: snapshot.data['smoke'] ?? '',
      drink: snapshot.data['drink'] ?? '',
      religion: snapshot.data['religion'] ?? '',
      job: snapshot.data['job'] ?? '',
      education: snapshot.data['education'] ?? '',
      prelocation: snapshot.data['prelocation'] ?? '',
      minage: snapshot.data['minage'] ?? '',
      maxage: snapshot.data['maxage'] ?? '',
      distance: snapshot.data['distance'] ?? '',
      pregender: snapshot.data['pregender'] ?? '',
      preheight: snapshot.data['preheight'] ?? '',
      photoUrl: snapshot.data['photoUrl']?? ''
    );
  }

  //user info list from stream
  List<InfoProfile> _infolistFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return InfoProfile(
        name: doc.data['name'] ?? '',
        age: doc.data['age'] ?? '',
        email: doc.data['email'] ?? '',
        location: doc.data['location'] ?? '',
        bio: doc.data['bio'] ?? '',
        currentSex: doc.data['currentSex'] ?? '',
        height: doc.data['height'] ?? '',
        smoke: doc.data['smoke'] ?? '',
        drink: doc.data['drink'] ?? '',
        religion: doc.data['religion'] ?? '',
        job: doc.data['job'] ?? '',
        education: doc.data['education'] ?? '',
        prelocation: doc.data['prelocation'] ?? '',
        minage: doc.data['minage'] ?? '',
        maxage: doc.data['maxage'] ?? '',
        distance: doc.data['distance'] ?? '',
        pregender: doc.data['pregender'] ?? '',
        preheight: doc.data['preheight'] ?? '',
        photoUrl: doc.data['photoUrl'] ?? '',
      );
    }).toList();
  }

  //get user doc stream

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userdatafromSnapShot);
  }

  //get user stream
  Stream<List<InfoProfile>> get profileinfo {
    return userCollection.snapshots().map(_infolistFromSnapshot);
  }
}
