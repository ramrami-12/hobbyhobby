import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hobbyhobby/screens/PostListPage/post_list.dart';

import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: const MyHomePage(title: 'Post Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: movePage,
              child: Text(
                '페이지 이동',
                style: TextStyle(
                  fontFamily: 'NanumSquareRoundR',
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void movePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => postlistPage()),
    );
  }
}
