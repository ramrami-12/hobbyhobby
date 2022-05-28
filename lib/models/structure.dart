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

class SmallGroups {
  SmallGroups({this.Mission, this.group_id, this.group_members, this.chat});

  dynamic group_id;
  dynamic group_members;
  dynamic Mission;
  dynamic chat;
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
      {this.email,
      this.points,
      this.prefers,
      this.profile_image_id,
      this.sex,
      this.user_id,
      this.user_name,
      this.personality});
  dynamic email;
  dynamic points;
  dynamic profile_image_id;
  dynamic sex;
  dynamic user_id;
  dynamic user_name;
  dynamic prefers;
  dynamic personality;
}

class Preferences {
  Preferences({
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
