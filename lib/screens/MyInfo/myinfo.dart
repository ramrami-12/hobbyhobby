// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:group_button/group_button.dart';
import 'package:hobbyhobby/screens/homePage/home.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../models/structure.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({required this.uid});
  final String uid;

  @override
  State<MyInfo> createState() => _MyInfo();
}

CollectionReference users = FirebaseFirestore.instance.collection('Users');


class _MyInfo extends State<MyInfo> {
  late Preferences currentUser;
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final textFieldController = TextEditingController();
  var _image_;
  String name = "";
  String sex = "";
  String personality = "";

  Future<void> updateData() async {
    return users.doc(widget.uid).update({
      "user_name": name,
      "sex": sex,
      "personality": personality,
      "profile_image_id": _image_,
    }).then((value) => print("update !"));
  }

  // final DocumentReference prefer = FirebaseFirestore.instance.collection('Users').doc(widget.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      updateData()
                          .whenComplete(() => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              ));
                    }),
                padding: EdgeInsets.only(left: 100, right: 100),
              ),
              SizedBox(height: 20),
            ],
          )),
    );
  }

  Widget imageProfile() {
    return Center(
        child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80,
          // ignore: unnecessary_null_comparison
          backgroundImage: AssetImage('assets/images/app_logo.png'),

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
                onPressed: () async {
                  XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    _image_ = File(image!.path);
                  });

                  // takePhoto(ImageSource.gallery);
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
