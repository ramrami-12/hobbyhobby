import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({ Key? key }) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){}, child: const Text('add User'));
  }
}