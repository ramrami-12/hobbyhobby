// written by haram
import 'package:flutter/material.dart';
import 'package:hobbyhobby/models/firebase.dart';
import 'package:hobbyhobby/models/preference.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({Key? key, this.pre, this.userId}) : super(key: key);
  final pre;
  final userId;
  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  Preference pre = Preference();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 53,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xffEBEBEB))),
        onPressed: () async {
          // updatePreferences(pre, widget.userId);
        },
        child: Text(
          '정보 저장',
          style: TextStyle(
            fontFamily: 'NanumSquareRoundR',
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
