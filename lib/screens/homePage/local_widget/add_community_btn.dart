import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/screens/communityListPage/community_list.dart';

class AddCommunityButton extends StatefulWidget {
  const AddCommunityButton({Key? key}) : super(key: key);

  @override
  State<AddCommunityButton> createState() => _AddCommunityButtonState();
}

class _AddCommunityButtonState extends State<AddCommunityButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xffFFFACC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
        ),
        onPressed: () {
          Get.to(CommunitylistPage());
        },
        child: Text(
          'Add My Community !',
          style: TextStyle(
            fontFamily: 'NanumSquareRoundR',
            fontSize: 23,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
