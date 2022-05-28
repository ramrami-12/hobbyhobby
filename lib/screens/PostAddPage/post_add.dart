import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:hobbyhobby/models/firebase.dart';
import 'package:path/path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hobbyhobby/screens/PostListPage/post_list.dart';

import '../../models/structure.dart';

class PostAddPage extends StatefulWidget {
  const PostAddPage({required this.addPost, required this.post});
  final FutureOr<void> Function(String pic, String content, bool _ischecked)
      addPost;
  final List<Post> post;

  @override
  State<PostAddPage> createState() => _AddPageState();
}

class _AddPageState extends State<PostAddPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_AddPageState');
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  bool _ischecked = false;
  PickedFile? _image;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  Future getImage() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  Future<String> uploadFile(File file) async {
    final firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(_controller.text);
    final firebase_storage.UploadTask task = ref.putFile(file);

    try {
      firebase_storage.TaskSnapshot snapshot = await task;
    } on FirebaseException catch (e) {
      print(task.snapshot);
      // e.g, e.code == 'canceled'
    }
    final String url = (await ref.getDownloadURL());
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),

            // appBar: AppBar(
            //   title: Text("ADD POST"),
            //   backgroundColor: Colors.green,
            //   centerTitle: true,
            //   actions: <Widget>[
            //     TextButton(
            //       style: TextButton.styleFrom(
            //         textStyle: const TextStyle(fontSize: 30, color: Colors.black),
            //       ),
            //       child: Text(
            //         'Save',
            //         style: TextStyle(fontSize: 20, color: Colors.black),
            //       ),
            //       onPressed: () async {
            //         if (_formKey.currentState == null) {
            //           print("_formKey.currentState is null!");
            //         } else if (_formKey.currentState!.validate()) {
            //           String fileName;
            //           String url;
            //           if (_image != null) {
            //             fileName = basename(_image!.path);
            //             url = await uploadFile(File(_image!.path));
            //           } else {
            //             url = '';
            //           }
            //           await widget.addPost(url, _controller.text, _controller2.text);
            //           print(_controller.text);

            //           _controller.clear();
            //           _controller2.clear();
            //           setState(() {
            //             _image = null;
            //           });
            //           Navigator.pop(context);

            //           //uploadImageToFirebase();

            //         }
            //       },
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Text('게시글 작성',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: TextFormField(
                        //         controller: _controller,
                        //         decoration: const InputDecoration(
                        //           hintText: 'Title',
                        //         ),
                        //         validator: (value) {
                        //           if (value == null || value.isEmpty) {
                        //             return 'Enter your message to continue';
                        //           }
                        //           return null;
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFFFACC),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    maxLines: 7,
                                    controller: _controller2,
                                    decoration: const InputDecoration(
                                      hintText: '',
                                      fillColor: Colors.yellow,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.yellow, width: 3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter your message to continue';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150.0,
                          child: Center(
                            child: _image == null
                                ? Image.asset('assets/images/hobby.png')
                                : Image.file(File(_image!.path)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                              onPressed: getImage,
                              tooltip: 'getGalleryImage',
                              child: Icon(Icons.camera_alt),
                              focusColor: Colors.yellow,
                            ),
                          ],
                        ),
                        Container(
                          height: 25,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(width: 250),
                            Text(
                              '인증용',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Checkbox(
                                value: _ischecked,
                                activeColor: Color(0xffC8FFCD),
                                checkColor: Colors.black,
                                onChanged: (value) {
                                  setState(() {
                                    _ischecked = value!;
                                  });
                                })
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 160,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState == null) {
                                      print("_formKey.currentState is null!");
                                    } else if (_formKey.currentState!
                                        .validate()) {
                                      String fileName;
                                      String url;
                                      if (_image != null) {
                                        fileName = basename(_image!.path);
                                        url = await uploadFile(
                                            File(_image!.path));
                                      } else {
                                        url = '';
                                      }
                                      await widget.addPost(
                                          url, _controller2.text, _ischecked);
                                      print(_controller.text);

                                      _controller.clear();
                                      _controller2.clear();
                                      setState(() {
                                        _image = null;
                                      });

                                      Get.back();

                                      //uploadImageToFirebase();

                                    }
                                  },

                                  // Respond to button press

                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffD7E9FF),
                                    shape: StadiumBorder(),
                                  ),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 160,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Respond to button press
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffFFFACC),
                                    shape: StadiumBorder(),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
