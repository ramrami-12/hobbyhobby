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
  SmallGroups(
      {required this.Mission,
      required this.group_id,
      required this.group_members,
      required this.chat});
  final String group_id;
  final List<Users> group_members;
  final List<String> Mission;
  final Chats chat;
}

class Communities {
  Communities({
    required this.com_detail,
    required this.com_id,
    required this.com_name,
    required this.hash_tag,
    required this.members,
    required String title,
    required String content,
  });
  final String com_detail;
  final String com_id;
  final String com_name;
  final List<String> hash_tag;
  final List<Users> members;
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
