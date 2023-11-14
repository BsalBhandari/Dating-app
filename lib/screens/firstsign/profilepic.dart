import 'dart:io';
import 'dart:math';
import 'package:genix/models/users.dart';
import 'package:genix/screens/mainscreen/Home.dart';
import 'package:genix/services/database.dart';
import 'package:genix/utilis/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class SelectProfilePic extends StatefulWidget {
  @override
  _SelectProfilePicState createState() => _SelectProfilePicState();
}

class _SelectProfilePicState extends State<SelectProfilePic> {
  var photo = 'https://www.booksie.com/files/profiles/22/mr-anonymous_230x230.png';
  var profilePicUrl =
      'https://www.booksie.com/files/profiles/22/mr-anonymous_230x230.png';
  @override
  void initState() {
    // TODO: implement shouldReclip
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        profilePicUrl = photo;
      });
    }).catchError((e) => print(e));
  }

  File newProfilePic;
  DatabaseService databaseService = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: newProfilePic == null ? getChooseButton() : getUploadButton(),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      newProfilePic = tempImage;
    });
  }

  Future UploadImage() async {
    var randomno = Random(25);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profilepic/${randomno.nextInt(1000).toString()}.jpg');
    StorageUploadTask task = firebaseStorageRef.putFile(newProfilePic);
    task.onComplete.then((value) {
      setState(() {
        photo = value.ref.getDownloadURL().toString();
        debugPrint(photo);
      });
      databaseService
          .updateProfilePic(value.ref.getDownloadURL.toString())
          .then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home())));
    }).catchError((e) {
      print(e);
    });
  }

  Widget getChooseButton() {
    return new Stack(children: <Widget>[
      ClipPath(
        child: Container(color: Colors.black.withOpacity(0.8)),
        clipper: getClipper(),
      ),
      Positioned(
          width: 350.0,
          top: MediaQuery.of(context).size.height / 5,
          child: Column(children: <Widget>[
            Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: NetworkImage(profilePicUrl), fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    boxShadow: [
                      BoxShadow(blurRadius: 7.0, color: Colors.black)
                    ])),
            SizedBox(
              height: 90.0,
            ),
            Text(
              'You have Signed Up',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Choose a Profile Picture',
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: getImage,
                      child: Center(
                        child: Text(
                          'Change Profile Pic',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ]))
    ]);
  }

  Widget getUploadButton() {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return new Stack(children: <Widget>[
              ClipPath(
                child: Container(color: Colors.black.withOpacity(0.8)),
                clipper: getClipper(),
              ),
              Positioned(
                  width: 350.0,
                  top: MediaQuery.of(context).size.height / 5,
                  child: Column(children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: FileImage(newProfilePic),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(
                      height: 90.0,
                    ),
                    Text(
                      'You have Signed Up',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Tap Upload to proceed',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 30.0,
                          width: 95.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: RaisedButton(
                              color: Colors.green,
                              onPressed: () async {
                                UploadImage();
                                await DatabaseService(uid: user.uid)
                                    .updateUserInfo(
                                        userData.name,
                                        userData.age,
                                        userData.email,
                                        userData.bio,
                                        userData.location,
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
                                        photo ?? userData.photoUrl);
                              },
                              child: Center(
                                child: Text(
                                  'Upload',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ]))
            ]);
          }else{
            return Loading();
          }
        });
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
