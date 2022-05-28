import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/screens/communityDetailPage/community_detail.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:hobbyhobby/models/firebase.dart';
import 'package:get/get.dart';
import 'dart:math';

// import 'firebase_options.dart';                    // new

import 'package:path/path.dart';

class CommunitylistPage extends StatefulWidget {
  @override
  _CommunitylistPageState createState() => _CommunitylistPageState();
}

class _CommunitylistPageState extends State<CommunitylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(children: [TopBar(), CommunityList()]),
      body: SafeArea(
        child: Column(children: [
          TopBar(),
          SizedBox(height: 20),
          Expanded(child: CommunityList())
        ]),
      ),
    );
  }
}

// Community의 List를 GridView로 나타내는 Class
class CommunityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Communities").snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, int index) {
                Map<String, dynamic> docData =
                    snapshot.data!.docs[index].data();
                String docID = snapshot.data.docs[index].id;
                if (docData.isEmpty) {
                  return const Text("empty");
                } else {
                  String com_name = docData['com_name'];
                  return GestureDetector(
                    onTap: () {
                      print(com_name);
                      Get.to(
                        CommunityDetailPage(),
                        arguments: [docData, docID],
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color(0xffFFFACC),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              com_name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          TagList(
                            docData['hash_tag'],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}

Widget TagList(hashTagList) {
  return Expanded(
    child: Container(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            childAspectRatio: 1 / 0.4,
            crossAxisSpacing: 3,
            mainAxisSpacing: 5),
        itemCount: hashTagList.length >= 3 ? 3 : hashTagList.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            child: Center(
              child: Text(
                '#' + hashTagList[index],
                style: TextStyle(fontSize: 13),
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
  );
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          SizedBox(width: 10),
          Container(
            width: 88.35,
            child: ElevatedButton(
              onPressed: () {
                // Respond to button press
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffFFCDCD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // <-- Radius
                ),
              ),
              child: Text(
                'Back',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
