// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class MyCommunityButton extends StatefulWidget {
  const MyCommunityButton({
    Key? key,
    required this.items,
  }) : super(key: key);
  final items;

  @override
  State<MyCommunityButton> createState() => _MyCommunityButtonState();
}

class _MyCommunityButtonState extends State<MyCommunityButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < widget.items.length; i++)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffFFFACC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
            onPressed: () {},
            child: Text(
              widget.items[i],
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
