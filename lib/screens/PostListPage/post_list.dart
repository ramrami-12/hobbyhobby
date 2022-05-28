import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hobbyhobby/main.dart';
import 'package:hobbyhobby/screens/communityDetailPage/community_detail.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:hobbyhobby/models/firebase.dart';
import 'package:like_button/like_button.dart';
import '../PostAddPage/post_add.dart';
// import 'firebase_options.dart';
import 'package:path/path.dart';
import 'package:hobbyhobby/main.dart';
import 'package:hobbyhobby/screens/PostListPage/chat_list.dart';

import '../groupPage/group.dart';

import '../../models/structure.dart';

class PostListPage extends StatefulWidget {
  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  @override
  Widget build(BuildContext context) {
    final comData = Get.arguments[0];
    final docID = Get.arguments[1];
    final docIdx = Get.arguments[2];
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    print(docIdx);

    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Color(0xffD7E9FF),
      //   fixedColor: Colors.black,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.description, color: Colors.black),
      //       label: 'Posts',
      //       backgroundColor: Color(0xffD7E9FF),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.groups, color: Colors.black),
      //       label: 'Groups',
      //       backgroundColor: Color(0xffD7E9FF),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home, color: Colors.black),
      //       label: 'Home',
      //       backgroundColor: Color(0xffD7E9FF),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history, color: Colors.black),
      //       label: 'History',
      //       backgroundColor: Color(0xffD7E9FF),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.tune, color: Colors.black),
      //       label: 'Preference',
      //       backgroundColor: Color(0xffD7E9FF),
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,

      //   // selectedItemColor: Color(0xffFDCDCD),
      //   onTap: _onItemTapped,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            TitleSection(docIdx, docID),
            Expanded(child: PostListSection(docID, docIdx)),
            BottomBar(comData, docID, docIdx),
          ],
        ),
      ),
    );
  }
}

class PostListSection extends StatelessWidget {
  final docID;
  final docIdx;
  late var like;

  // CollectionReference user = FirebaseFirestore.instance.collection('Users');

  PostListSection(this.docID, this.docIdx);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Communities')
          .doc(docID)
          .collection('Post')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (ctx, index) {
              // varwriter = collectionStream.docs()
              // DocumentSnapshot writer = await user
              //     .doc(snapshot.rdata.docs[index].data()['userId'].toString())
              //     .get()
              //     ;
              // var w = writer.;
              // print(w);
              // StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
              //     collectionStream = FirebaseFirestore.instance
              //         .collection('Users')
              //         .snapshots()
              //         .listen((data) {
              //           String writer = data.docs(snapshot.data.docs[index].data()['user_name'].toString()).
              //   // print(data.docs);
              //   data.docs.forEach((element) {

              //     print(element);
              //   });
              // });
              Future<bool> onLikeButtonTapped(bool isLiked) async {
                /// send your request here
                // final bool success= await sendRequest();

                /// if failed, you can do nothing
                // return success? !isLiked:isLiked;

                return !isLiked;
              }

              return Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color(0xffD7E9FF),
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(8),
                      width: 338,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Text('사진'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '지현',
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  snapshot.data.docs[index].data()['created'] ==
                                          null
                                      ? Text("")
                                      : Text(
                                          snapshot.data.docs[index]
                                              .data()['created']
                                              .toDate()
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                              child: Text(
                            snapshot.data.docs[index]
                                .data()['content']
                                .toString(),
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                          Row(
                            children: [
                              // Container(
                              //     child: IconButton(
                              //   color: like % 2 == 0
                              //       ? Colors.amber
                              //       : Colors.yellow,
                              //   icon: Icon(Icons.thumb_up_alt_rounded),
                              //   onPressed: () async {},
                              // )),
                              LikeButton(
                                onTap: onLikeButtonTapped,
                              ),
                              SizedBox(width: 170),
                              Container(
                                child: TextButton.icon(
                                  icon: Icon(Icons.chat_outlined),
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: Color(0xffD7E9FF),
                                  ),
                                  label: Text(
                                    '댓글',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    String postID =
                                        snapshot.data.docs[index].id;
                                    Get.to(
                                      ChatListPage(),
                                      arguments: [docID, docIdx, postID],
                                    );
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      )

                      // Container(
                      //   child: Text(snapshot.data.docs[index]
                      //       .data()['created']
                      //       .toDate()
                      //       .toString()),
                      // ),
                      ),
                ],
              );
            });
      },
    );
  }
}

class TitleSection extends StatelessWidget {
  final int docIdx;
  final String docID;
  final user = FirebaseAuth.instance.currentUser!;
  TitleSection(this.docIdx, this.docID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("Communities").snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Map<String, dynamic> docData = snapshot.data!.docs[docIdx].data();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      docData["com_name"],
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: FloatingActionButton(
                      onPressed: () {
                        print("press");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostAddPage(
                                addPost: (pic, content, mission) =>
                                    ProductList.addPostToCommunity(
                                        pic, content, mission, docID, user.uid),
                                post: ProductList._letter,
                              ),
                            ));
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xffFFC700),
                    ),
                  ),
                )
              ],
            );
          }
        });
  }
}

class ProductList extends ChangeNotifier {
  final int docIdx;

  ProductList(this.docIdx) {
    init();
  }

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      // if (user != null) {
      _guestBookSubscription = FirebaseFirestore.instance
          .collection('Post')
          // .orderBy('price', descending: false)
          .snapshots()
          .listen((snapshot) {
        for (final document in snapshot.docs) {
          //Product Image, Name, Price and Description
          _letter.add(
            Post(
              pic: document.data()['pic'] as String,
              title: document.data()['title'] as String,
              content: document.data()['content'] as String,
              mission: document.data()['mission'] as bool,
              doc_id: document.id,
              like: [""],
              index: "0",
              created: FieldValue.serverTimestamp().toString(),
            ),
          );
        }
        notifyListeners();
      });
      //   } else {
      //     _letter = [];
      //     _guestBookSubscription?.cancel(); // new
      //   }
      //   notifyListeners();
      //
    });
  }

  String? _email;
  String? get email => _email;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  static List<Post> _letter = [];
  static List<Post> get letter => _letter;
  static String _docid = "";
  static String get docid => _docid;
  // final String pic;
  // final String title;
  // final String doc_id;
  // final String content;
  // final List<String> like;
  // final int index;

  // static Future<DocumentReference> addCommunity(String title, String content) {
  //   return FirebaseFirestore.instance
  //       .collection('Community')
  //       .add(<String, dynamic>{
  //     'title': title,
  //     'content': content,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //     'like': "",
  //     'index': -1,
  //     'created': FieldValue.serverTimestamp(),
  //   });
  // }

  static Future<DocumentReference> addPostToCommunity(
      String pic, String content, bool mission, String docID, String uid) {
    return FirebaseFirestore.instance
        .collection('Communities')
        .doc(docID)
        .collection('Post')
        .add(<String, dynamic>{
      'pic': pic,
      'title': "",
      'content': content,
      'mission': mission,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'like': "",
      'index': -1,
      'created': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentReference> updateMessageToGuestBook(
      String title, String content) {
    return FirebaseFirestore.instance
        .collection('Community')
        .add(<String, dynamic>{
      'title': title,
      'content': content,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> MissionList = [
      "평봉에서 만남",
      "취미 활동 진행",
      "함께 인증사진 찍기",
      "줌 미팅",
      "카페가기",
      "한동 한바퀴",
      "다같이 공부"
    ];
    int rnd = Random().nextInt(7);

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width: 10),

          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ElevatedButton(
              onPressed: () {
                print('Alert!');
                // Respond to button press
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return Center(
                      child: Container(
                        width: 800,
                        child: Column(
                          children: [
                            AlertDialog(
                              insetPadding: EdgeInsets.only(top: 200),
                              backgroundColor: Color(0xffFFCDCD),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              content: Stack(children: [
                                Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 80),
                                      Text(
                                        "Mission",
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(MissionList[rnd],
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      SizedBox(height: 80),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: FlatButton(
                                    child: new Text("X"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffFFCDCD),
                shape: StadiumBorder(),
              ),
              child: Text(
                'Mission',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ElevatedButton.icon(
              onPressed: () {
                StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
                    collectionStream = FirebaseFirestore.instance
                        .collection('Communities')
                        .snapshots()
                        .listen((data) {
                  print(data.docs);
                  print("hello");
                  data.docs.forEach((element) {
                    // print(element['com_name']);
                    print(data.docs[0].id);
                  });
                });
              },
              icon: Icon(
                // <— Icon
                Icons.storefront_sharp,
                color: Colors.black,
                size: 24.0,
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: Color(0xffC8FFCD),
              ),
              label: Text(
                'Store',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ), // <— Text
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final comData;
  final docID;
  final idx;

  BottomBar(this.comData, this.docID, this.idx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
              color: Color(0xffFFCDCD),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.description),
                onPressed: () {},
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.groups),
                onPressed: () {
                  Get.to(
                    GroupPage(
                      userId: user.uid,
                    ),
                    arguments: [comData, docID, idx],
                  );
                  print("Group");
                },
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Get.toNamed('home');
                  print("Pressed");
                },
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 82.5,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.history_outlined),
                onPressed: () {},
              )),
          Container(
              color: Color(0xffD7E9FF),
              width: 83,
              height: 80,
              // height: 100,
              child: IconButton(
                icon: Icon(Icons.tune_rounded),
                onPressed: () {
                  Get.toNamed('/prefer');
                },
              ))
          // tune_rounded
        ],
      ),
    );
  }
}
