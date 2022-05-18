// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
// written by haram
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/models/firebase.dart';
import 'package:hobbyhobby/models/structure.dart';
import 'package:hobbyhobby d/screens/MyPreferencePage/local_widget/my_button.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/local_widget/my_dropdown_button.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/local_widget/save_button.dart';
import 'package:hobbyhobby/components/bottom_bar.dart';
import '../../components/bottom_bar.dart';
import 'local_widget/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyPreferPage extends StatefulWidget {
  const MyPreferPage({Key? key}) : super(key: key);

  @override
  State<MyPreferPage> createState() => _MyPreferPageState();
}

class _MyPreferPageState extends State<MyPreferPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  Preferences pre = Preferences();

  final comData = Get.arguments[0];
  final docID = Get.arguments[1];
  final docIdx = Get.arguments[2];

  List<String> _maxCostItems = ['1만원 이하', '1~3만원', '3~5만원', '5만원 이상'];
  List<String> _purposeItems = ['배움', '재미', '입문'];
  List<String> _maxMeetItems = ['주 1~2회', '주 3~4회', '주 5회 이상'];

  @override
  Widget build(BuildContext context) {
    try {
      var temp_prefer_time = Set();
      DocumentReference prefers = FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .collection('Preferences')
          .doc(currentUser.uid);
      print('check the firebase ${prefers}');

      // updatePreferences(pre, currentUser.uid);

      return Scaffold(
          body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Text(
              'My Preference',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'NanumSquareRoundR',
                fontSize: 26,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: FutureBuilder<DocumentSnapshot>(
              future: prefers.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('error@@!');
                }

                if (snapshot.hasData) {
                  print(snapshot.data!);

                  // Map<dynamic, dynamic> data =
                  //     snapshot.data!.data() as Map<String, dynamic>;

                  // pre.isActivity = data['is_activity'];
                  // pre.isGroupQuiet = data['is_group_quiet'];
                  // pre.isSameSex = data['is_same_sex'];
                  // pre.maxCost = data['max_cost'];
                  // pre.maxMeet = data['max_meet'];
                  // pre.preferTime = data['prefer_time'];
                  // pre.purpose = data['purpose'];

                  // error is occured when read the db
                  pre.isActivity = 0;
                  pre.isGroupQuiet = 1;
                  pre.isSameSex = 0;
                  pre.maxCost = '5만원 이상';
                  pre.maxMeet = '주 1~2회';
                  pre.preferTime = [1, 0, 1, 0];
                  pre.purpose = '재미';

                  // print(is_activity);
                  // print(prefer_time);
                  // print(max_cost);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MyButton(
                          title: '활동',
                          items: ['on', 'off'],
                          isSelected: (val, index, isSelected) {
                            print('$val $index button $isSelected');
                            index = pre.isActivity;
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      MyButton(
                          title: '성별',
                          items: ['동성', '혼성'],
                          isSelected: (val, index, isSelected) {
                            print('$val $index button $isSelected');
                            index = pre.isSameSex;
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      MyButtons(
                          title: '시간대',
                          items: ['주말', '평일', '오전', '오후'],
                          isSelected: (val, index, isSelected) {
                            print('$val $index button $isSelected');

                            if (isSelected == true) {
                              temp_prefer_time.add(index);
                            } else {
                              temp_prefer_time.remove(index);
                            }
                            print(temp_prefer_time);
                            pre.preferTime = temp_prefer_time;
                            print(pre.preferTime);
                            // index
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      MyDropDownButton(
                        title: '1회 만남 최대 비용',
                        selectValue: pre.maxCost,
                        selectList: _maxCostItems,
                        onChanged: (newValue) {
                          setState(() {
                            _maxMeetItems = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      MyButtonTriple(
                          title: '목적',
                          items: ['배움', '재미', '입문'],
                          isSelected: (val, index, isSelected) {
                            print('$val $index button $isSelected');
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      MyDropDownButton(
                        title: '최대 만남 횟수',
                        selectValue: pre.maxMeet,
                        selectList: _maxMeetItems,
                        onChanged: (newValue) {
                          setState(() {
                            _maxMeetItems = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      MyButton(
                          title: '그룹 성향',
                          items: ['활발', '조용'],
                          isSelected: (val, index, isSelected) {
                            print('$val $index button $isSelected');
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      SaveButton(pre: pre, userId: currentUser.uid),
                      SizedBox(
                        height: 200,
                      ),
                      BottomBar_prefer(comData, docID, docIdx),
                    ],
                  );
                }
                return CircularProgressIndicator();
              },
            )),
          ],
        ),
      ));
    } catch (e) {
      return Scaffold();
    }
  }
}
