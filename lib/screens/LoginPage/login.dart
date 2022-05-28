// ignore_for_file: deprecated_member_use

// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:hobbyhobby/screens/MyInfo/myinfoMain.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:firebase_database/firebase_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hobbyhobby/screens/MyInfo/myinfo.dart';

import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../models/structure.dart';

// class Users {
//   Users(
//       {required this.email,
//       required this.points,
//       required this.prefer,
//       required this.profile_image_id,
//       required this.sex,
//       required this.user_id,
//       required this.user_name});
//   final String email;
//   final String points;
//   final String profile_image_id;
//   final bool sex;
//   final String user_id;
//   final String user_name;
//   final Preferences prefer;
// }

// class Preferences {
//   Preferences(
//       {required this.is_activity,
//       required this.is_group_quiet,
//       required this.is_same_sex,
//       required this.max_cost,
//       required this.max_meet,
//       required this.prefer_time,
//       required this.purpose});
//   final bool is_activity;
//   final bool is_group_quiet;
//   final bool is_same_sex;
//   final int max_cost;
//   final int max_meet;
//   final List<String> prefer_time;
//   final List<String> purpose;
// }
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late Users currentUser;
  String? name = "";
  String? email = "";
  String? url = "";
  String? uid = "";
//   Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//   final UserCredential authResult = await _auth.signInWithCredential(credential);

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
//   CollectionReference user = FirebaseFirestore.instance.collection('user');
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final String? user = authResult.user?.uid;

    setState(() {
      email = authResult.user?.email;
      url = authResult.user?.photoURL;
      name = authResult.user?.displayName;
      uid = authResult.user?.uid;
    });
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<void> createData() async {
    return users.doc(uid).set({
      "email": email,
      "profile_image_id": url,
      "points": 0,
      "sex": "",
      "user_id": uid,
      "user_name": name,
      "personality": ""
    }).then((value) => print("movie add!"));
  }

  // Future<void> addUser() async{
  //   return user.doc(uid).update({
  //     'create' : true
  //   }).then((value) => print("user add!"));
  // }
  // final user = FirebaseDatabase().reference().child('Users');

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  // Text(
                  //   "나만의 영화 기록장",
                  //   style: TextStyle(fontFamily: 'DoHyeon', fontWeight: FontWeight.w900),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(right: 100, left: 100),
                    child: Image.asset('assets/images/hobby.png',
                        width: 200, height: 200, fit: BoxFit.cover),
                  ),
                  // SignInButtonBuilder(
                  //   text: 'Sign in with Email',
                  //   icon: Icons.email,
                  //   onPressed: () {},
                  //   backgroundColor: Colors.blueGrey[700]!,
                  // )
                  FloatingActionButton.extended(
                    // color: Colors.grey.withOpacity(0.3),
                    onPressed: () {
                      signInWithGoogle().whenComplete(() {
                        createData();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            // builder: (context) => MyInfoMain(
                            //   uid: uid as String,
                            //   imgName: '',
                            //   personality: '',
                            //   name: '',
                            //   sex: '',
                            //   tmp: 0,
                            // ),
                            builder: (context) => MyInfo(
                              uid: uid as String,
                            ),
                          ),
                          // MaterialPageRoute(
                          //   builder: (context) => MyInfo(
                          //     uid: uid as String,
                          //   ),
                          // ),
                        );
                        print(uid);
                      });
                    },
                    //  (){
                    //   Get.to(LoginPage());
                    //   print('hi');
                    // }

                    label: Text('SIGN IN WITH GOOGLE'),
                    icon: Icon(Icons.security),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,

                    // ()
                    // {
                    //   signInWithGoogle();

                    //   print('hello');
                    //   signInWithGoogle().whenComplete(() {
                    //     addUser();
                    //     Navigator.of(context).push(
                    //       MaterialPageRoute(
                    //         builder: (context)=> new MyApp(),
                    //         // builder: (context)=> new MyApp(uid: uid,),

                    //       ),
                    //     );
                    //   }
                    //   );
                    // },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

googleLogin() async {
  print("googleLogin method Called");
  GoogleSignIn _googleSignIn = GoogleSignIn();
  try {
    var reslut = await _googleSignIn.signIn();
    if (reslut == null) {
      return;
    }

    final userData = await reslut.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken, idToken: userData.idToken);
    var finalResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print("Result $reslut");
    print(reslut.displayName);
    print(reslut.email);
    print(reslut.photoUrl);
  } catch (error) {
    print(error);
  }
}

Future<void> logout() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}
