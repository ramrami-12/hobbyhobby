// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'dart:core';

import 'package:hobbyhobby/screens/PostListPage/post_list.dart';

class CommunityDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic arguments = Get.arguments;
    dynamic comDetailData = arguments[0];
    String docID = arguments[1];
    int idx = arguments[2];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            SizedBox(height: 10),
            TitleSection(comDetailData['com_name']),
            SizedBox(height: 40),
            DetailSection(comDetailData['com_detail']),
            SizedBox(height: 20),
            TagList(comDetailData['hash_tag'].cast<String>()),
            JoinButton(comDetailData, docID, idx),
          ],
        ),
      ),
    );
  }
}

class JoinButton extends StatelessWidget {
  final comData;
  final String docID;
  final int idx;
  final user = FirebaseAuth.instance.currentUser!;

  JoinButton(this.comData, this.docID, this.idx);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 140,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            String userID = "testUser";

            FirebaseFirestore.instance
                .collection('Communities')
                .doc(docID)
                .set({
              'members': FieldValue.arrayUnion([user.uid])
            }, SetOptions(merge: true));
            print(user.uid);

            Get.to(
              PostListPage(),
              arguments: [comData, docID, idx],
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xffD7E9FE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // <-- Radius
            ),
          ),
          child: Text(
            'Join',
            style: TextStyle(
              fontFamily: "Nunito",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}

class TagList extends StatelessWidget {
  final List<String> communityTagList;
  TagList(this.communityTagList);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      margin: EdgeInsets.fromLTRB(14, 0, 14, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '관심분야_#',
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1 / 0.4,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 5),
                itemCount: communityTagList.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                    child: Center(
                      child: Text(
                        '#' + communityTagList[index].toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailSection extends StatelessWidget {
  final String communityDetail;
  DetailSection(this.communityDetail);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        margin: EdgeInsets.fromLTRB(14, 0, 14, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '모집글',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
              child: Text(
                communityDetail,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold,
                  color: Color(0xff808080),
                ),
              ),
            ),
          ],
        ));
  }
}

class TitleSection extends StatelessWidget {
  final String communityName;
  TitleSection(this.communityName);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 255,
        height: 65,
        decoration: BoxDecoration(
            color: Color(0xffFFFACC), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            communityName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> MissionList = [
      "평봉에서 만남",
      "취미 활동 진행",
      "함께 인증사진 찍기",
      "줌 미팅",
      "카페가기",
      "한동 한바퀴",
      "다같이 공부"
    ];
    int rnd = Random().nextInt(7);

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width: 10),

          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ElevatedButton(
              onPressed: () {
                print('Alert!');
                // Respond to button press
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return Center(
                      child: Container(
                        width: 800,
                        child: Column(
                          children: [
                            AlertDialog(
                              insetPadding: EdgeInsets.only(top: 200),
                              backgroundColor: Color(0xffFFCDCD),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              content: Stack(children: [
                                Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 80),
                                      Text(
                                        "Mission",
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(MissionList[rnd],
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      SizedBox(height: 80),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: FlatButton(
                                    child: new Text("X"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffFFCDCD),
                shape: StadiumBorder(),
              ),
              child: Text(
                'Mission',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ElevatedButton.icon(
              onPressed: () {
                StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
                    collectionStream = FirebaseFirestore.instance
                        .collection('Communities')
                        .snapshots()
                        .listen((data) {
                  print(data.docs);
                  print("hello");
                  data.docs.forEach((element) {
                    // print(element['com_name']);
                    print(data.docs[0].id);
                  });
                });
              },
              icon: Icon(
                // <— Icon
                Icons.storefront_sharp,
                color: Colors.black,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Color(0xffC8FFCD),
              ),
              label: Text(
                'Store',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ), // <— Text
            ),
          ),
        ],
      ),
    );
  }
}
