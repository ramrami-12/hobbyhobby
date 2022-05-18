// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/my_peference.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                Get.to(MyPreferPage());
              },
              child:
              Text(
                '페이지 이동',
                style: TextStyle(
                  fontFamily: 'NanumSquareRoundR',
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}