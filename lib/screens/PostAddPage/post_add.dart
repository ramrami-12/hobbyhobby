import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firebase_storage;
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hobbyhobby/models/firebase.dart';
import 'package:path/path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hobbyhobby/screens/PostListPage/post_list.dart';

class PostAddPage extends StatefulWidget {
  const PostAddPage({required this.addPost, required this.post});
  final FutureOr<void> Function(String pic, String title, String content)
      addPost;
  final List<Post> post;

  @override
  State<PostAddPage> createState() => _AddPageState();
}

class _AddPageState extends State<PostAddPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_AddPageState');
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
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
      appBar: AppBar(
        title: Text("ADD POST"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 30, color: Colors.black),
            ),
            child: Text(
              'Save',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            onPressed: () async {
              if (_formKey.currentState == null) {
                print("_formKey.currentState is null!");
              } else if (_formKey.currentState!.validate()) {
                String fileName;
                String url;
                if (_image != null) {
                  fileName = basename(_image!.path);
                  url = await uploadFile(File(_image!.path));
                } else {
                  url = '';
                }
                await widget.addPost(url, _controller.text, _controller2.text);
                print(_controller.text);

                _controller.clear();
                _controller2.clear();
                setState(() {
                  _image = null;
                });
                Navigator.pop(context);

                //uploadImageToFirebase();

              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
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
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Title',
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller2,
                          decoration: const InputDecoration(
                            hintText: 'Content',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
