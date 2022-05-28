// written by haram from yeeun's code
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

class TopBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> _missionList = [
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
          MissionButton(missionList: _missionList, rnd: rnd),
          StoreButton(),
        ],
      ),
    );
  }
}

class MissionButton extends StatefulWidget {
  const MissionButton({
    Key? key,
    required this.missionList,
    required this.rnd,
  }) : super(key: key);
  final missionList;
  final rnd;

  @override
  State<MissionButton> createState() => _MissionButtonState();
}

class _MissionButtonState extends State<MissionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                                Text(widget.missionList[widget.rnd],
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
                              child: const Text("X"),
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
    );
  }
}

class StoreButton extends StatefulWidget {
  const StoreButton({Key? key}) : super(key: key);

  @override
  State<StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<StoreButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ElevatedButton.icon(
        onPressed: () {
          // StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
          //     collectionStream = FirebaseFirestore.instance
          //         .collection('Communities')
          //         .snapshots()
          //         .listen((data) {
          //   print(data.docs);
          //   print("hello");
          //   data.docs.forEach((element) {
          //     // print(element['com_name']);
          //     print(data.docs[0].id);
          //   });
          // });
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
    );
  }
}
