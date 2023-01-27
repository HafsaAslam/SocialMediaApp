import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late final String id;
  late final String postText;
  late final String uid;
  late final String userImage;
  late final String userName;
  late final String? postImage;
  late final String dateTime;
  late final int likesCount;
  late final int commentsCount;
  // default constructor
  PostModel({
    required this.uid,
    required this.id,
    required this.postText,
    required this.userImage,
    required this.userName,
    this.postImage,
    required this.dateTime,
    required this.likesCount,
    required this.commentsCount,
  });

  // for post creation
  PostModel.withoutId(
      {required this.uid,
      required this.postText,
      required this.userImage,
      this.postImage,
      required this.dateTime,
      required this.userName});
  // when we read data from firebase this will be used for converting DocumentSnapshot to model object
  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    uid = documentSnapshot['uid'] ?? "";
    postText = documentSnapshot["postText"];
    postImage = documentSnapshot["postImage"] ?? "";
    userName = documentSnapshot["userName"] ?? "";
    userImage = documentSnapshot["userImage"] ?? "";
    likesCount = documentSnapshot["likesCount"] ?? 0;
    commentsCount = documentSnapshot["commentsCount"] ?? 0;
    dateTime = documentSnapshot["dateTime"] ?? DateTime.now().toString();
  }

  // this will be used to convert PostModel.withoutId to Map<String,dynamic>
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['id'] = id;
    data['postText'] = postText;
    data['postImage'] = postImage;
    data['userImage'] = userImage;
    data['dateTime'] = dateTime;
    data['userName'] = userName;

    return data;
  }

  PostModel.fromJson(Map<String, dynamic> json, String docId) {
    uid = json['uid'] ?? "";
    id = docId;
    userName = json['userName'] ?? "";
    postText = json['postText'] ?? "";
    userImage = json['userImage'] ?? "";
    dateTime = json['dateTime'] ?? "";
    postImage = json[' postImage'] ?? "";
  }
}
