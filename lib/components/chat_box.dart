// written by haram from yeeun's code

import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key, this.hintText}) : super(key: key);
  final hintText;
  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();
  // final String docID;
  // final String postID;
  // final user = FirebaseAuth.instance.currentUser!;
  // _GuestBookState(this.docID, this.postID);
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
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '입력하세요...',
                        // '댓글을 입력하세요...'
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
                      // ApplicationState.addChatToPost(
                      //     _controller.text, docID, postID, user.uid);

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
                ]))));
  }
}
