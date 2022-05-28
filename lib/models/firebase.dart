// written by haram
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobbyhobby/models/structure.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> getUserInfo(users, currentUser) async {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> collectionStream =
      FirebaseFirestore.instance
          //
          .collection('Users')
          .snapshots()
          .listen((data) {
    // print(data.docs);
    data.docs.forEach((element) {
      // print(element['com_name']);
      if (currentUser.uid == element.data()['user_id']) {
        print(data.docs[0]['user_name'].toString());
        //uid: user.uid, imgName: '', name: '', personality: '', sex: '', tmp: 0,
        users.user_name = data.docs[0]['user_name'].toString();
        users.profile_image_id = data.docs[0]['profile_image_id'].toString();
        users.sex = data.docs[0]['sex'].toString();
        users.personality = data.docs[0]['personality'].toString();
      }
    });
  });
}

Future<void> updatePreferences(Preferences pre, String userId) async {
  DocumentReference prefers = FirebaseFirestore.instance
      .collection('Users')
      .doc(userId)
      .collection('Preferences')
      .doc(userId);
  print(userId);
  return await prefers.update({
    "is_activity": pre.isActivity,
    "is_group_quiet": pre.isGroupQuiet,
    "is_same_sex": pre.isSameSex,
    // "max_cost": pre.maxCost,
    // "max_meet": pre.maxMeet,
    "prefer_time": pre.preferTime,
    "purpose": pre.purpose
  }).then((value) => print("preference info update!"));
}
