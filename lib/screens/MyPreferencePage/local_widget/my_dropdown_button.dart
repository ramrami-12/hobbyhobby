// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MyDropDownButton extends StatefulWidget {
  final String title;
  final String selectValue;
  final List<String>selectList;

  const MyDropDownButton(
      {Key? key,
      required this.title,
      required this.selectValue,
      required this.selectList})
      : super(key: key);

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        width: 20,
      ),
      Text(
        widget.title,
        style: TextStyle(
          fontFamily: 'NanumSquareRoundR',
          fontSize: 20,
        ),
      ),
      SizedBox(
        height: 20,
        width: 20,
      ),
      DropdownButton(
        value: widget.selectValue,
        items: widget.selectList.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (item) {
          setState(() {
            // this.widget.selectValue = 'item';
          });
        },
      ),
      SizedBox(height: 50),
    ]);
  }
}
