// ignore_for_file: prefer_const_constructors
// written by haram
import 'package:flutter/material.dart';
import 'package:hobbyhobby/models/structure.dart';
import 'package:group_button/group_button.dart';

class MyButton extends StatefulWidget {
  const MyButton(
      {Key? key,
      required this.title,
      required this.items,
      required this.isSelected})
      : super(key: key);
  final title;
  final items;
  final isSelected;
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late bool _isSelected = widget.isSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'NanumSquareRoundR',
              fontSize: 20,
            ),
          ),
          GroupButton(
              isRadio: true,
              onSelected: widget.isSelected,
              buttons: [widget.items[0], widget.items[1]],
              options: GroupButtonOptions(
                spacing: 1,
                groupingType: GroupingType.wrap,
                selectedShadow: const [],
                selectedColor: Color(0xffFFCDCD),
                unselectedShadow: const [],
                unselectedColor: Color(0xffD7E9FF),
                selectedTextStyle: TextStyle(color: Colors.black),
                unselectedTextStyle: TextStyle(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30),
              )),
        ]);
  }
}

class MyButtons extends StatefulWidget {
  const MyButtons(
      {Key? key,
      required this.title,
      required this.items,
      required this.isSelected})
      : super(key: key);
  final title;
  final items;
  final isSelected;
  @override
  State<MyButtons> createState() => _MyButtonsState();
}

class _MyButtonsState extends State<MyButtons> {
  late bool _isSelected = widget.isSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'NanumSquareRoundR',
              fontSize: 20,
            ),
          ),
          GroupButton(
              isRadio: false,
              onSelected: widget.isSelected,
              buttons: [
                widget.items[0],
                widget.items[1],
                widget.items[2],
                widget.items[3]
              ],
              options: GroupButtonOptions(
                spacing: 1,
                groupingType: GroupingType.wrap,
                selectedShadow: const [],
                selectedColor: Color(0xffFFCDCD),
                unselectedShadow: const [],
                unselectedColor: Color(0xffD7E9FF),
                selectedTextStyle: TextStyle(color: Colors.black),
                unselectedTextStyle: TextStyle(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30),
              ))
        ]);
  }
}

class MyButtonTriple extends StatefulWidget {
  const MyButtonTriple(
      {Key? key,
      required this.title,
      required this.items,
      required this.isSelected})
      : super(key: key);
  final title;
  final items;
  final isSelected;
  @override
  State<MyButtonTriple> createState() => _MyButtonTripleState();
}

class _MyButtonTripleState extends State<MyButtonTriple> {
  late bool _isSelected = widget.isSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'NanumSquareRoundR',
              fontSize: 20,
            ),
          ),
          GroupButton(
              isRadio: false,
              onSelected: widget.isSelected,
              buttons: [
                widget.items[0],
                widget.items[1],
                widget.items[2],
              ],
              options: GroupButtonOptions(
                spacing: 1,
                groupingType: GroupingType.wrap,
                selectedShadow: const [],
                selectedColor: Color(0xffFFCDCD),
                unselectedShadow: const [],
                unselectedColor: Color(0xffD7E9FF),
                selectedTextStyle: TextStyle(color: Colors.black),
                unselectedTextStyle: TextStyle(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30),
              ))
        ]);
  }
}
