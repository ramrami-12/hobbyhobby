// ignore_for_file: prefer_const_constructors
//refactoring by haram
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/screens/MyInfo/myinfo.dart';
import 'package:hobbyhobby/screens/MyInfo/myinfoMain.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/my_peference.dart';
import 'package:hobbyhobby/screens/communityListPage/community_list.dart';
import 'package:hobbyhobby/models/firebase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    _getUserInfo();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffFFFACC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () {
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
                      builder: (context) => CommunitylistPage(),
                    ),
                    // MaterialPageRoute(
                    //   builder: (context) => MyInfo(
                    //     uid: uid as String,
                    //   ),
                    // ),
                  );
                  // Get.to(CommunitylistPage());
                },
                child: Text(
                  'Add My Community !',
                  style: TextStyle(
                    fontFamily: 'NanumSquareRoundR',
                    fontSize: 23,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(MyInfoMain(
            uid: user.uid,
            imgName: imgName,
            name: name,
            personality: personality,
            sex: sex,
            tmp: 0,
          ));

          // Add your onPressed code here!
        },
        backgroundColor: Color(0xffD7E9FF),
        child: const Icon(Icons.person, color: Colors.black),
      ),
    );
  }
}
