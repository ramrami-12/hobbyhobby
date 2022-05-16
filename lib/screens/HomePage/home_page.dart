import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/screens/GroupPage/group.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:() {
      Get.to(()=> const GroupPage());
    }, child: const Text('Group'));
  }
}