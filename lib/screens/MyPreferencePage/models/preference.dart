// TODO Implement this library.
class Preference {
  Preference({
    this.isActivity,
    this.isGroupQuiet,
    this.isSameSex,
    this.maxCost,
    this.maxMeet,
    this.preferTime,
    this.purpose,
  });

  dynamic isActivity;
  dynamic isGroupQuiet;
  dynamic isSameSex;
  dynamic maxCost;
  dynamic maxMeet;
  dynamic preferTime;
  dynamic purpose;
}

class Post {
  static var post;

  Post(
      {required this.pic,
      required this.title,
      required this.doc_id,
      required this.content,
      required this.mission,
      required this.like,
      required this.index,
      required this.created});
  final String pic;
  final String title;
  final String doc_id;
  final String content;
  final String created;
  final List<String> like;
  final bool mission;
  final String index;
}

class SmallGroups {
  SmallGroups({this.Mission, this.group_id, this.group_members, this.chat});

  dynamic group_id;
  dynamic group_members;
  dynamic Mission;
  dynamic chat;
}

class Communities {
  Communities({
    this.com_detail,
    this.com_id,
    this.com_name,
    this.hash_tag,
    this.members,
    this.title,
    this.content,
  });
  dynamic com_detail;
  dynamic com_id;
  dynamic com_name;
  dynamic hash_tag;
  dynamic members;
  dynamic title;
  dynamic content;
}

class Chats {
  Chats(
      {required this.chat_content,
      required this.chat_id,
      required this.chat_writer,
      required this.date,
      required String name,
      required String message});

  final String chat_content;
  final String date;
  final String chat_id;
  final String chat_writer;
}

class Users {
  Users(
      {required this.email,
      required this.points,
      required this.prefer,
      required this.profile_image_id,
      required this.sex,
      required this.user_id,
      required this.user_name});
  final String email;
  final String points;
  final String profile_image_id;
  final bool sex;
  final String user_id;
  final String user_name;
  final Preferences prefer;
}

class Preferences {
  Preferences(
      {required this.is_activity,
      required this.is_group_quiet,
      required this.is_same_sex,
      required this.max_cost,
      required this.max_meet,
      required this.prefer_time,
      required this.purpose});
  final bool is_activity;
  final bool is_group_quiet;
  final bool is_same_sex;
  final int max_cost;
  final int max_meet;
  final List<String> prefer_time;
  final List<String> purpose;
}
