// written by haram
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hobbyhobby/components/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StoreButton(),
            ],
          ),
          Text(
            'My Communites',
            style: TextStyle(fontFamily: 'Nunito', fontSize: 24),
            // textAlign: TextAlign.left,
          ),
          //community button
          ElevatedButton(child: Text('Add My Community'), onPressed: (){}),
          Text(
            '인기 게시글',
            style: TextStyle(fontFamily: 'Nunito', fontSize: 24),
          ),
          SizedBox(
            width: 300,
            height: 330,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffD7E9FF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
            ),
          ),
          // frame
          FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.person_outline,
            ),
          )
        ],
      )),
    );
  }
}


// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hobbyhobby/screens/MyPreferencePage/my_peference.dart';
// import 'package:hobbyhobby/screens/communityListPage/community_list.dart';
// import 'package:hobbyhobby/screens/groupPage/group.dart';
// import 'package:hobbyhobby/models/firebase.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () {
//                   Get.to(MyPreferPage(userId: 'bNAQJdr1Uoi7iCylFkCo',));
//                 },
//                 child: Text(
//                   'Preferences',
//                   style: TextStyle(
//                     fontFamily: 'NanumSquareRoundR',
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Get.to(GroupPage(userId: 'bNAQJdr1Uoi7iCylFkCo',));
//                 },
//                 child: Text(
//                   'Group Page',
//                   style: TextStyle(
//                     fontFamily: 'NanumSquareRoundR',
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Color(0xffFFFACC),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10), // <-- Radius
//                     ),
//                   ),
//                   onPressed: () {
//                     Get.to(CommunitylistPage());
//                   },
//                   child: Text(
//                     'Add My Community !',
//                     style: TextStyle(
//                       fontFamily: 'NanumSquareRoundR',
//                       fontSize: 23,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
