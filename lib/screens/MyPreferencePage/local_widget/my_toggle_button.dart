// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MyToggleButton extends StatelessWidget {
  final title;
  final item1;
  final item2;
  final selections;
  final pressEvent;

  const MyToggleButton({
    Key? key,
    required this.title,
    required this.item1,
    required this.item2,
    required this.selections,
    required this.pressEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        width: 100,
      ),
      Text(
        this.title,
        style: TextStyle(
          fontFamily: 'NanumSquareRoundR',
          fontSize: 20,
        ),
      ),
      SizedBox(
        width: 20,
      ),
      ToggleButtons(
        children: <Widget>[
          Text(this.item1),
          Text(this.item2),
        ],
        onPressed: this.pressEvent,
        isSelected: this.selections,
      ),
      SizedBox(height: 80),
    ]);
  }
}
