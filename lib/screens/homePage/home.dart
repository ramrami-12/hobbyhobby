// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//refactoring by haram
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/components/top_bar.dart';
import 'package:hobbyhobby/screens/MyInfo/myinfo.dart';
import 'package:hobbyhobby/screens/MyInfo/myinfoMain.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/my_peference.dart';
import 'package:hobbyhobby/screens/communityListPage/community_list.dart';
import 'package:hobbyhobby/models/firebase.dart';
import 'package:hobbyhobby/models/structure.dart';
import 'package:hobbyhobby/screens/homePage/local_widget/add_community_btn.dart';
import 'package:hobbyhobby/screens/homePage/local_widget/my_community_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    Users users = Users();

    List<String> myComList = ['한동 오케스트라', '수영', '테니스'];

    getUserInfo(users, currentUser);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StoreButton(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'My Communities',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                MyCommunityButton(items: myComList),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                AddCommunityButton(),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  '인기 게시글',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 300,
                  height: 330,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffD7E9FF),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(MyInfoMain(
            uid: currentUser.uid,
            name: users.user_name,
            sex: users.sex,
            personality: users.personality,
            tmp: 0,
            imgName: users.profile_image_id,
          ));
        },
        backgroundColor: Color(0xffD7E9FF),
        child: const Icon(Icons.person, color: Colors.black),
      ),
    );
  }
}
