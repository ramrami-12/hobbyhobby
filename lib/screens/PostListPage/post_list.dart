import 'dart:async';
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
import 'dart:io';
import 'package:path/path.dart';
import 'package:hobbyhobby/models/firebase.dart';
import '../PostAddPage/post_add.dart';
import 'firebase_options.dart';
import 'package:path/path.dart';
import 'package:hobbyhobby/main.dart';

class postlistPage extends StatefulWidget {
  @override
  _postlistPageState createState() => _postlistPageState();
}

class _postlistPageState extends State<postlistPage> {
  StreamSubscription<QuerySnapshot>? _post;

  List<Post> _PostMessage = [];
  List<Post> get PostMessage => _PostMessage;
  var com_id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  // Respond to button press
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
              Container(
                width: 170,
              ),
              ElevatedButton.icon(
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
                      com_id = data.docs[0].id;
                      print(com_id);
                    });
                  });

                  // print(collectionStream.isEmpty);
                },
                icon: Icon(
                  // <-- Icon
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
                ), // <-- Text
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Communities')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(width: 20),
                          Text(
                            snapshot.data!.docs[0]['com_name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Container(
                            width: 180,
                          ),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: FloatingActionButton(
                              onPressed: () {
                                print("press");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PostAddPage(
                                        addPost: (pic, title, content) =>
                                            ProductList.addPostToCommunity(
                                                pic, title, content),
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
                          )
                        ],
                      ),
                    ],
                  );

                  //               // image: "aaa",
                  //               // category: snapshot.data.docs[index]['name'],
                  //               // numOfBrands: snapshot.data.docs[index]
                  //               //     ['maxcost'],
                  //               // press: () {},

                  //               // This trailing comma makes auto-f
                  //             ],
                  //           )),
                  //     ));
                }),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Post').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return SizedBox(
                      height: 130,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (ctx, index) => Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(snapshot.data!.docs[index]['title']),
                                Text(snapshot.data!.docs[index]['content']),
                              ],
                            )
                            // image: "aaa",
                            // category: snapshot.data.docs[index]['name'],
                            // numOfBrands: snapshot.data.docs[index]
                            //     ['maxcost'],
                            // press: () {},

                            ),
                      ));
                }),
          ),
        ],
      ),
    );
  }
}

// 미션 팝업창
// 댓글 페이지

class ProductList extends ChangeNotifier {
  ProductList() {
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
              doc_id: document.id,
              like: [""],
              index: -1,
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
      String pic, String title, String content) {
    return FirebaseFirestore.instance.collection('Post').add(<String, dynamic>{
      'pic': pic,
      'title': title,
      'content': content,
      // 'userId': FirebaseAuth.instance.currentUser!.uid,
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

// class Productlist extends ChangeNotifier {
//   ProductList() {
//     init();
//   }

//   Future<void> init() async {
//     await Firebase.initializeApp();
//   }
// }

// class _AddPageState extends State<AddPage> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_AddPageState');
//   final _controller = TextEditingController();
//   final _controller2 = TextEditingController();

//   FirebaseFirestore storage = FirebaseFirestore.instance;

//   // final picker = ImagePicker();
//   // Future getImage () async {
//   //   final image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//   //   setState((){
//   //     _image = image!;
//   //   });
//   // Future<String> uploadFile() async {
//   //   final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
//   //       .ref(_controller.text);
//   //   // final firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
//   //   //     .ref(_controller.text)
//   //   //     .putFile(file);
//   //   //print(file);

//   //   try {
//   //     firebase_storage.TaskSnapshot snapshot = await task;

//   //   } on FirebaseException catch (e) {
//   //     print(task.snapshot);
//   //     // e.g, e.code == 'canceled'
//   //   }
//   //   final String url = (await ref.getDownloadURL());
//   //   return url;
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add"),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('Save', style: TextStyle(fontSize: 15)),
//             onPressed: () async {
//               if (_formKey.currentState == null) {
//                 print("_formKey.currentState is null!");
//               } else if (_formKey.currentState!.validate()) {
//                 String fileName;
//                 String url;
//                 // if(_image!=null){
//                 //   fileName = basename(_image!.path);
//                 //   url = await uploadFile(File(_image!.path));
//                 // }
//                 // else{
//                 //   url='';
//                 // }
//                 // await widget.addMessage(_controller.text,_controller2.text);

//                 _controller.clear();
//                 _controller2.clear();
//                 // setState((){
//                 //   _image=null;
//                 // });
//                 Navigator.pop(context);

//                 //uploadImageToFirebase();

//               }
//             },
//             textColor: Colors.white,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 200.0,
//               child: Center(
//                   // child : _image ==null
//                   //     ?Image.asset('assets/images/leaf.png')
//                   //     :Image.file(File(_image!.path)),
//                   ),
//             ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   children: [
//             //     FloatingActionButton(
//             //       onPressed: getImage,
//             //       tooltip: 'getGalleryImage',
//             //       child : Icon(Icons.camera_alt),
//             //     ),
//             //   ],
//             // ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: _controller,
//                           decoration: const InputDecoration(
//                             hintText: 'Title',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Enter your message to continue';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: _controller2,
//                           decoration: const InputDecoration(
//                             hintText: 'Content',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Enter your message to continue';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
