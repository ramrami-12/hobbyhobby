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
import 'package:hobbyhobby/screens/PostListPage/post_list.dart';
import 'package:hobbyhobby/screens/communityDetailPage/community_detail.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:hobbyhobby/models/firebase.dart';
// import 'package:provider/provider.dart';
import '../PostAddPage/post_add.dart';
// import 'firebase_options.dart';
import 'package:path/path.dart';
import 'package:hobbyhobby/main.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final docID = Get.arguments[0];
    final docIdx = Get.arguments[1];
    final postID = Get.arguments[2];
    print(docIdx);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            TitleSection(docIdx, docID, postID),
            Container(
              width: 338,
              height: 600,
              color: Color(0xffD7E9FF),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: Icon(Icons.close, color: Colors.black),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xffD7E9FF),
                        ),
                        label: Text(
                          '',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  Expanded(child: ChatListSection(docID, postID)),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      child: GuestBook(docID, postID),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    ),
                  )

                  // Consumer<ApplicationState>(
                  //   builder: (context, appState, _) => Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       //if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  //       GuestBook(
                  //         addMessage: (message) => appState.addMessageToGuestBook(
                  //             message, docID, postID),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GuestBook extends StatefulWidget {
  final String postID;
  final String docID;

  GuestBook(this.docID, this.postID);

  // const GuestBook({required this.addMessage});
  // final FutureOr<void> Function(String message) addMessage;

  @override
  _GuestBookState createState() => _GuestBookState(docID, postID);
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();
  final String docID;
  final String postID;
  final user = FirebaseAuth.instance.currentUser!;
  _GuestBookState(this.docID, this.postID);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffEBEBEB),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '댓글을 입력하세요...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your message to continue';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              MaterialButton(
                onPressed: () {
                  ApplicationState.addChatToPost(
                      _controller.text, docID, postID, user.uid);

                  _controller.clear();
                },
                color: Color(0xffEBEBEB),
                textColor: Colors.black,
                child: Icon(
                  Icons.send,
                  size: 24,
                ),
                // padding: EdgeInsets.all(8),
                shape: CircleBorder(),
              )
              // TextButton(
              //   onPressed: () async {
              //     if (_formKey.currentState!.validate()) {
              //       // await widget.addMessage(_controller.text);
              //       _controller.clear();
              //     }
              //   },
              //   child: Row(
              //     children: const [
              //       Icon(Icons.send),
              //       SizedBox(width: 4),
              //       // Text('SEND'),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ApplicationState extends ChangeNotifier {
//   ApplicationState() {
//     init();
//   }

//   Future<void> init() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     FirebaseAuth.instance.userChanges().listen((user) {
//       if (user != null) {
//         // _loginState = ApplicationLoginState.loggedIn;
//         _guestBookSubscription = FirebaseFirestore.instance
//             .collection('guestbook')
//             .orderBy('timestamp', descending: true)
//             .snapshots()
//             .listen((snapshot) {
//           _guestBookMessages = [];
//           for (final document in snapshot.docs) {
//             _guestBookMessages.add(
//               Chats(
//                 chat_content: document.data()['text'] as String,
//                 chat_id: document.id,
//                 chat_writer: '',
//                 date: FieldValue.serverTimestamp().toString(),
//                 name: '',
//                 message: '',
//               ),
//             );
//           }
//           notifyListeners();
//         });
//         _guestBookMessages = [];
//         _guestBookSubscription?.cancel();
//         _attendingSubscription?.cancel();
//       }
//       notifyListeners();
//     });
//   }

//   String? _email;
//   String? get email => _email;

//   StreamSubscription<QuerySnapshot>? _guestBookSubscription;
//   List<Chats> _guestBookMessages = [];
//   List<Chats> get guestBookMessages => _guestBookMessages;

//   int _attendees = 0;
//   int get attendees => _attendees;

//   StreamSubscription<DocumentSnapshot>? _attendingSubscription;

//   void startLoginFlow() {
//     // _loginState = ApplicationLoginState.emailAddress;
//     notifyListeners();
//   }

//   Future<DocumentReference> addChatToPost(
//       String message, String docID, String postID) {
//     // if (_loginState != ApplicationLoginState.loggedIn) {
//     //   throw Exception('Must be logged in');
//     // }

//     return FirebaseFirestore.instance
//
class ChatListSection extends StatelessWidget {
  final String docID;
  final String postID;

  ChatListSection(this.docID, this.postID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Communities')
          .doc(docID)
          .collection('Post')
          .doc(postID)
          .collection('Chats')
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (ctx, index) {
              return Container(
                child: Column(
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
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: Text('사진'),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '예은',
                                      style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        snapshot.data.docs[index]
                                            .data()['chat_content']
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: "Nunito",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                ),
              );
            });
      },
    );
  }
}

class TitleSection extends StatelessWidget {
  final int docIdx;
  final String docID;
  final String postID;
  TitleSection(this.docIdx, this.docID, this.postID);

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
                  width: 180,
                ),
              ],
            );
          }
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

class ApplicationState extends ChangeNotifier {
  static String? docIdx;

  ProductList() {
    init();
  }

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      // if (user != null) {
      _guestBookSubscription = FirebaseFirestore.instance
          .collection('Chats')
          // .orderBy('price', descending: false)
          .snapshots()
          .listen((snapshot) {
        for (final document in snapshot.docs) {
          //Product Image, Name, Price and Description
          _letter.add(
            Chats(
              chat_content: document.data()['message'] as String,
              chat_id: document.id,
              date: FieldValue.serverTimestamp().toString(),
              message: '',
              chat_writer: user!.uid,
              name: '',
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
  static List<Chats> _letter = [];
  static List<Chats> get letter => _letter;
  static String _docid = "";
  static String get docID => _docid;
  static String _postid = "";
  static String get postID => _postid;
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

  static Future<DocumentReference> addChatToPost(
      String message, String docID, String postID, String uid) {
    return FirebaseFirestore.instance
        .collection('Communities')
        .doc(docID)
        .collection('Post')
        .doc(postID)
        .collection('Chats')
        .add(<String, dynamic>{
      'chat_content': message,
      'chat_id': '',
      'date': FieldValue.serverTimestamp().toString(),
      'message': message,
      'chat_writer': uid,
      'name': '',
    });
  }

  // Future<DocumentReference> updateMessageToGuestBook(
  //     String title, String content) {
  //   return FirebaseFirestore.instance
  //       .collection('Community')
  //       .add(<String, dynamic>{
  //     'title': title,
  //     'content': content,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //   });
  // }
}
