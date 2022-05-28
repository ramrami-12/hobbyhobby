// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
// written by haram

import 'package:flutter/material.dart';
import 'package:hobbyhobby/models/firebase.dart';
import 'package:hobbyhobby/models/structure.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/local_widget/my_button.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/local_widget/my_dropdown_button.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/local_widget/save_button.dart';
import 'local_widget/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPreferPage extends StatefulWidget {
  const MyPreferPage({Key? key, this.userId, required String title})
      : super(key: key);
  final userId;
  @override
  State<MyPreferPage> createState() => _MyPreferPageState();
}

class _MyPreferPageState extends State<MyPreferPage> {
  Preferences pre = Preferences();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> _maxCostItems = ['1만원 이하', '1~3만원', '3~5만원', '5만원 이상'];
  List<String> _purposeItems = ['배움', '재미', '입문'];
  List<String> _maxMeetItems = ['주 1~2회', '주 3~4회', '주 5회 이상'];

  @override
  Widget build(BuildContext context) {
    try {
      var temp_prefer_time = Set();
      DocumentReference prefers = FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userId)
          .collection('Preferences')
          .doc(widget.userId);

      updatePreferences(pre, widget.userId);

      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xffD7E9FF),
            fixedColor: Colors.black,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.description, color: Colors.black),
                label: 'Posts',
                backgroundColor: Color(0xffD7E9FF),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups, color: Colors.black),
                label: 'Groups',
                backgroundColor: Color(0xffD7E9FF),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: 'Home',
                backgroundColor: Color(0xffD7E9FF),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history, color: Colors.black),
                label: 'History',
                backgroundColor: Color(0xffD7E9FF),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tune, color: Colors.black),
                label: 'Preference',
                backgroundColor: Color(0xffD7E9FF),
              ),
            ],
            currentIndex: _selectedIndex,

            // selectedItemColor: Color(0xffFDCDCD),
            onTap: _onItemTapped,
          ),
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
                height: 50,
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
                    Map<dynamic, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    pre.isActivity = data['is_activity'];
                    pre.isGroupQuiet = data['is_group_quiet'];
                    pre.isSameSex = data['is_same_sex'];
                    pre.maxCost = data['max_cost'];
                    pre.maxMeet = data['max_meet'];
                    pre.preferTime = data['prefer_time'];
                    pre.purpose = data['purpose'];

                    // print(is_activity);
                    // print(prefer_time);
                    // print(max_cost);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          height: 60,
                        ),
                        SaveButton(pre: pre, userId: widget.userId)
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              )),
            ],
          )));
    } catch (e) {
      return Scaffold();
    }
  }
}
