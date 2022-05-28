// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/firebase_options.dart';
import 'package:hobbyhobby/screens/LoginPage/login.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/my_peference.dart';
import 'package:hobbyhobby/screens/groupPage/group.dart';
import 'screens/homePage/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(name: '/group', page: () => GroupPage(userId: user!.uid)),
        // GetPage(
        //   name: '/two',
        //   page: () => SecondPage(),
        // ),
        // GetPage(
        //   name: '/three',
        //   page: () => ThirdPage(),
        // ),
        // GetPage(
        //   name: '/a/b/c1',
        //   page: () => ABCOnePage(),
        // ),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
