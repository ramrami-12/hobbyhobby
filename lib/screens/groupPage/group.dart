// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// written by haram
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/components/top_bar.dart';
import 'package:hobbyhobby/components/chat_box.dart';
import 'package:hobbyhobby/models/structure.dart';
import 'package:hobbyhobby/screens/communityDetailPage/community_detail.dart';
import 'package:hobbyhobby/components/bottom_bar.dart';
import '../../models/structure.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key, required this.userId}) : super(key: key);
  final userId;
  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  SmallGroups group = SmallGroups();
  Communities com = Communities();
  final comData = Get.arguments[0];
  final docID = Get.arguments[1];
  final docIdx = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    com.com_name = "To Be Revealed";
    com.members = ["user1", "user2", "user3"];
    return Scaffold(
      body: SafeArea(
          child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TopBars(),
          Text(
            '${com.com_name}',
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
            child: Container(
              alignment: Alignment.center,
              color: Color(0xffFFFACC),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var i = 0; i < com.members.length; i++)
                      Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 40,
                                // ignore: unnecessary_null_comparison
                                backgroundColor: Color(0xffFFCDCD),

                                // AssetImage(
                                // imgName == null ? 'images/app_logo.png' : imgName,
                                // ),
                              )
                            ],
                          ),
                          Text(
                            com.members[i],
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                  ]),
            ),
          ),
          SizedBox(
            height: 450,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'To Be Revealed',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff757575)),
              ),
            ),
          ),
          ChatBox(),
          BottomBar_group(comData, docID, docIdx),
        ],
      )),
    );
  }
}
