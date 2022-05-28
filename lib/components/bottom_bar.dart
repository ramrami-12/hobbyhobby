import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/PostListPage/post_list.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
              color: Color(0xffFFCDCD),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.description),
                onPressed: () {},
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.groups),
                onPressed: () {},
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Get.toNamed('home');
                  print("Pressed");
                },
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.history_outlined),
                onPressed: () {},
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 83,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.tune_rounded),
                onPressed: () {},
              ))
          // tune_rounded
        ],
      ),
    );
  }
}

class BottomBar_group extends StatelessWidget {
  final comData;
  final docID;
  final int idx;
  BottomBar_group(this.comData, this.docID, this.idx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.description),
                onPressed: () {
                  Get.to(
                    PostListPage(),
                    arguments: [comData, docID, idx],
                  );
                },
              )),
          Container(
              color: Color(0xffFFCDCD),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.groups),
                onPressed: () {},
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Get.toNamed('home');
                  print("Pressed");
                },
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.history_outlined),
                onPressed: () {},
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 83,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.tune_rounded),
                onPressed: () {},
              ))
          // tune_rounded
        ],
      ),
    );
  }
}
