import 'package:flutter/material.dart';

// 포인트 몇점인지 보여주고 상점으로 이동하는 버튼
class PointButton extends StatelessWidget {
  const PointButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){

      },
      child: Text('Points'),
    );
  }
}