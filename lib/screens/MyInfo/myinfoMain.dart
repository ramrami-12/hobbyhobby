// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:group_button/group_button.dart';
import 'package:hobbyhobby/screens/LoginPage/login.dart';
import 'package:hobbyhobby/screens/homePage/home.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../models/firebase.dart';

class MyInfoMain extends StatefulWidget {
  MyInfoMain(
      {required this.uid,
      required this.name,
      required this.sex,
      required this.personality,
      required this.imgName,
      required this.tmp});

  final String uid;
  final String name;
  final String sex;
  final String personality;
  final int tmp;
  final String imgName;

  @override
  State<MyInfoMain> createState() => _MyInfoMain();
}

CollectionReference users = FirebaseFirestore.instance.collection('Users');

// Future<void> addPreference() async{
//     return prefer.add({
//       'timeStamp' : FieldValue.serverTimestamp(),
//       'movieName' : movieName,
//       'score' : score != ""?double.parse(score):0,
//       'director' : director,
//       'photo' : url,
//       'review' : review,
//       'genre' : genre != ""?genre:"",
//       'id' : widget.userID,
//       'openingDate' : openingDate,

//     }).then((value) => print("movie add!"));
//   }
class _MyInfoMain extends State<MyInfoMain> {
  late Preferences currentUser;
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final textFieldController = TextEditingController();

  String name = "";
  String sex = "";
  String personality = "";
  int tmp = 0;
  String imgName = "";
  String uid = "";
  Future<void> updateData() async {
    return users.doc(widget.uid).update({
      "user_name": name,
      "sex": sex,
      "personality": personality
    }).then((value) => print("update !"));
  }

  // final DocumentReference prefer = FirebaseFirestore.instance.collection('Users').doc(widget.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Page'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(widget.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData && !snapshot.data!.exists) {
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              print("Full Name: ${data['user_name']} ${data['sex']}");
              print(uid + sex + name);

              uid = widget.uid;
              name = data['user_name'];
              sex = data['sex'];
              personality = data['personality'];
              // tmp = items[4];
              imgName = data['profile_image_id'];
              print(uid + sex + name);

              // users.doc(widget.uid).get().then((value) {
              //   var documents = snapshot.data?.docs;
              //   setState(() {
              //     uid = widget.uid;
              //     name = documents![1]['user_name'];
              //     sex = documents[1]['sex'];
              //     personality = documents![1]['personality'];
              //     // tmp = items[4];
              //     imgName = documents![1]['profile_image_id'];
              //   });

              //   print("hi!!!!");
              // }

              return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: ListView(
                    children: <Widget>[
                      imageProfile(),
                      SizedBox(height: 40),
                      nameTextField('이름'),
                      makeButtonTextLineSex('성별'),
                      makeButtonTextLinePers('성격'),
                      // makeTempBarTextLine('매너온도'),
                      SizedBox(height: 80),
                      Container(
                        child: Column(
                          children: <Widget>[
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.grey[400],
                                    minimumSize: Size(200, 40)),
                                child: Text('정보수정',
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.black)),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MyInfoEdit(
                                          widget.uid,
                                          name,
                                          sex,
                                          personality,
                                          tmp,
                                          imgName),
                                    ),
                                  );
                                }),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    minimumSize: Size(200, 40),
                                    backgroundColor: Colors.pink[100]),
                                child: Text('로그아웃',
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.black)),
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                                }),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        padding: EdgeInsets.only(left: 100, right: 100),
                      ),
                      SizedBox(height: 20),
                    ],
                  ));
            }

            return CircularProgressIndicator();
          },
        ));
  }

  Widget imageProfile() {
    return Center(
        child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80,
          // ignore: unnecessary_null_comparison
          backgroundImage: AssetImage(
            imgName == null ? 'images/app_logo.png' : imgName,
          ),
          // imgName == null? "images/app_logo.png" : AssetImage(imgName),

          // backgroundImage: _imageFile == null? AssetImage('images/app_logo.png'):FileImage(File(_imageFile.path)),
        ),
      ],
    ));
  }

  Widget nameTextField(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeTextField(title),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 4, bottom: 4),
    );
  }

  Widget makeText(String title) {
    return Text(title,
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold));
  }

  Widget makeTextField(String title) {
    return Container(
      child: Text(
        name,
      ),
      width: 200,
      padding: EdgeInsets.only(left: 16),
    );
  }

  Widget makeButtonTextLineSex(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeButtonSex(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 4, bottom: 4),
    );
  }

  Widget makeButtonTextLinePers(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeButtonPers(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 4, bottom: 4),
    );
  }

  Widget makeButtonSex() {
    return Center(
      child: GroupButton(
        isRadio: true,
        // spacing: 30,

        buttons: ['여', '남'],
        options: GroupButtonOptions(
          selectedBorderColor: Colors.lightBlueAccent,
          unselectedBorderColor: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(100),
          spacing: 10,
          selectedColor: Colors.pink[100],
        ),
      ),
    );
  }

  Widget makeButtonPers() {
    return Center(
      child: GroupButton(
        isRadio: true,
        // spacing: 30,
        // onSelected: (index, isSeleted)=>print('$index buttonn is selected'),
        buttons: ['활발', '조용'],
        onSelected: (String selectedPers, int selectedIndex, bool isSelected) {
          print("pers = " + selectedPers);
          personality = selectedPers;
        },
        options: GroupButtonOptions(
          selectedBorderColor: Colors.lightBlueAccent,
          unselectedBorderColor: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(100),
          spacing: 10,
          selectedColor: Colors.pink[100],
        ),
      ),
    );
  }

  Widget makeTempBarTextLine(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeTempBar(),
          Container(
            child: makeText('36.7°C'),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 8, bottom: 40),
    );
  }

  Widget makeTempBar() {
    return LinearPercentIndicator(
      linearStrokeCap: LinearStrokeCap.roundAll,
      width: 140.0,
      lineHeight: 14.0,
      percent: 0.5,
      backgroundColor: Colors.grey,
      progressColor: Colors.blue,
    );
  }

  // ignore: non_constant_identifier_names
  Widget BottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                  size: 50,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text(
                  'Camera',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                  size: 50,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}

/////////////////////////////////////////////////
class MyInfoEdit extends StatefulWidget {
  MyInfoEdit(
      this.uid, this.name, this.sex, this.personality, this.tmp, this.imgName);
  final String name;
  final String sex;
  final String personality;
  final int tmp;
  final String imgName;
  final String uid;

  @override
  _MyInfoEdit createState() => _MyInfoEdit();
}

class _MyInfoEdit extends State<MyInfoEdit> {
  late Preferences currentUser;
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final textFieldController = TextEditingController();

  String name = "";
  String sex = "";
  String personality = "";
  String photo = "";

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Future<void> updateUser() {
    print(widget.uid);
    return users
        .doc(widget.uid)
        .update({"user_name": name, "sex": sex, "personality": personality})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  // final DocumentReference prefer = FirebaseFirestore.instance.collection('Users').doc(widget.uid);
  @override
  Widget build(BuildContext context) {
    name = widget.name;
    sex = widget.sex;
    personality = widget.personality;
    photo = widget.imgName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ListView(
            children: <Widget>[
              imageProfile(),
              SizedBox(height: 20),
              nameTextField('이름'),
              makeButtonTextLineSex('성별'),
              makeButtonTextLinePers('성격'),
              // makeTempBarTextLine('매너온도'),
              Container(
                child: RaisedButton(
                    child: Text('완료', style: TextStyle(fontSize: 21)),
                    onPressed: () {
                      name = '${textFieldController.text}';
                      updateUser()
                          .whenComplete(() => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(title: 'Homepage'),
                                ),
                              ));
                    }),
                padding: EdgeInsets.only(left: 100, right: 100),
              ),
              SizedBox(height: 20),
            ],
          )),
    );

    // return Scaffold(
    //     body: StreamBuilder<DocumentSnapshot>(
    //   stream: FirebaseFirestore.instance
    //       .collection("Users")
    //       .doc(widget.uid)
    //       .snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData || !snapshot.data!.exists) {
    //       return CircularProgressIndicator();
    //     } else if (snapshot.hasData) {
    //       final items = snapshot.data;

    //       Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    //           child: ListView(
    //             children: <Widget>[
    //               imageProfile(),
    //               SizedBox(height: 20),
    //               nameTextField('이름'),
    //               makeButtonTextLineSex('성별'),
    //               makeButtonTextLinePers('성격'),
    //               makeTempBarTextLine('매너온도'),
    //               Container(
    //                 child: RaisedButton(
    //                     child: Text('완료', style: TextStyle(fontSize: 21)),
    //                     onPressed: () {
    //                       updateUser();
    //                       Navigator.of(context).pop();
    //                     }),
    //                 padding: EdgeInsets.only(left: 100, right: 100),
    //               ),
    //               SizedBox(height: 20),
    //             ],
    //           ));
    //     }

    //     return CircularProgressIndicator();
    //   },
    // ));
  }

  Widget imageProfile() {
    return Center(
        child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80,
          // ignore: unnecessary_null_comparison
          backgroundImage: AssetImage('images/app_logo.png'),

          // backgroundImage: _imageFile == null? AssetImage('images/app_logo.png'):FileImage(File(_imageFile.path)),
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => BottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 40,
              ),
            ))
      ],
    ));
  }

  Widget nameTextField(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeTextField(title),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 4, bottom: 4),
    );
  }

  Widget makeText(String title) {
    return Text(title,
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold));
  }

  Widget makeTextField(String title) {
    return Container(
      child: TextField(
        decoration: InputDecoration(),
        controller: textFieldController,
      ),
      width: 200,
      padding: EdgeInsets.only(left: 16),
    );
  }

  Widget makeButtonTextLineSex(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeButtonSex(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 4, bottom: 4),
    );
  }

  Widget makeButtonTextLinePers(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeButtonPers(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 4, bottom: 4),
    );
  }

  Widget makeButtonSex() {
    return Center(
      child: GroupButton(
        isRadio: true,
        // spacing: 30,
        onSelected: (String selectedSex, int selectedIndex, bool isSelected) {
          print("sex = " + selectedSex);
          sex = selectedSex;
        },
        buttons: ['여', '남'],
        options: GroupButtonOptions(
          selectedBorderColor: Colors.lightBlueAccent,
          unselectedBorderColor: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(100),
          spacing: 10,
          selectedColor: Colors.pink[100],
        ),
      ),
    );
  }

  Widget makeButtonPers() {
    return Center(
      child: GroupButton(
        isRadio: true,
        // spacing: 30,
        // onSelected: (index, isSeleted)=>print('$index buttonn is selected'),
        buttons: ['활발', '조용'],
        onSelected: (String selectedPers, int selectedIndex, bool isSelected) {
          print("pers = " + selectedPers);
          personality = selectedPers;
        },
        options: GroupButtonOptions(
          selectedBorderColor: Colors.lightBlueAccent,
          unselectedBorderColor: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(100),
          spacing: 10,
          selectedColor: Colors.pink[100],
        ),
      ),
    );
  }

  Widget makeTempBarTextLine(String title) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeTempBar(),
          Container(
            child: makeText('36.7°C'),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 30, right: 60, top: 8, bottom: 40),
    );
  }

  Widget makeTempBar() {
    return LinearPercentIndicator(
      linearStrokeCap: LinearStrokeCap.roundAll,
      width: 140.0,
      lineHeight: 14.0,
      percent: 0.5,
      backgroundColor: Colors.grey,
      progressColor: Colors.blue,
    );
  }

  // ignore: non_constant_identifier_names
  Widget BottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                  size: 50,
                ),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text(
                  'Camera',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                  size: 50,
                ),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}
