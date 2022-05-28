import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hobbyhobby/models/preference.dart';
// import 'package:hobbyhobby/models/preference.dart';

 Future<void> updatePreferences(Preference pre, String userId) async {
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