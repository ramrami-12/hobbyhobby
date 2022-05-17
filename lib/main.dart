import 'package:flutter/material.dart';
import 'package:hobbyhobby/screens/MyPreferencePage/my_peference.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Preference Page'),
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
              child:
              Text(
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => myPreferPage()),);
  }
}
