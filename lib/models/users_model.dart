import 'package:cloud_firestore/cloud_firestore.dart';

class UserModelFireBase {
  UserModelFireBase({
    this.profileImageUrl,
    this.coverImageUrl,
    required this.id,
    required this.createdAt,
    required this.firstName,
    required this.imageUrl,
    required this.lastSeen,
    required this.updatedAt,
    required this.metadata,
  });
  late final String id;

  late final String? profileImageUrl, coverImageUrl;

  late final Timestamp createdAt;
  late final String firstName;
  late final String imageUrl;
  late final Timestamp lastSeen;
  late final Timestamp updatedAt;
  late final Metadata metadata;

  UserModelFireBase.fromJson(Map<String, dynamic> json, String docId) {
    profileImageUrl = json['profileImageUrl'] ?? '';
    coverImageUrl = json['coverImageUrl'] ?? '';

    id = docId;

    createdAt = json['createdAt'] ?? "";
    firstName = json['firstName'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
    lastSeen = json['lastSeen'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    metadata = Metadata.fromJson(json['metadata'] ?? {});
  }
  // users: (json['users'] as List<dynamic>)
  //         .map((e) => User.fromJson(e as Map<String, dynamic>))
  //         .toList(),
  UserModelFireBase.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    profileImageUrl = data['profileImageUrl'] ?? "";
    coverImageUrl = data['coverImageUrl'] ?? "";
    id = documentSnapshot.id;

    createdAt = data['createdAt'] ?? "";
    firstName = data['firstName'] ?? "";
    imageUrl = data['imageUrl'] ?? "";
    lastSeen = data['lastSeen'] ?? "";
    updatedAt = data['updatedAt'] ?? "";
    metadata = Metadata.fromJson(data['metadata']);
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};

    _data['profileImageUrl'] = profileImageUrl;
    _data['coverImageUrl'] = coverImageUrl;

    _data['createdAt'] = createdAt;
    _data['firstName'] = firstName;
    _data['imageUrl'] = imageUrl;
    _data['lastSeen'] = lastSeen;
    _data['updatedAt'] = updatedAt;
    _data['metadata'] = metadata.toJson();
    return _data;
  }
}

class Metadata {
  Metadata(
      {required this.email,
      //required this.address,
      required this.phone,
      required this.password,
      required this.uid
      // required this.dob,
      // required this.gender,
      // required this.lat,
      // required this.lng,
      });
  late final String email;
  late final String phone;
  late final String password;
  late final String uid;

  //late final String address;

  // late final String dob;
  // late final String gender;
  // late final String lat;
  // late final String lng;

  Metadata.fromJson(Map<String, dynamic> json) {
    password = json['password'] ?? "";
    email = json['email'] ?? "";
    uid = json['uid'] ?? "";
    // coverImageUrl = json['coverImageUrl'] ?? "";
    // dob = json['dob'] ?? "";
    // gender = json['gender'] ?? "";
    // lat = json['lat'] ?? "";
    // lng = json['lng'] ?? "";
    phone = json['phone'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['password'] = password;
    _data[' email'] = email;
    _data[' uid'] = uid;
    // _data['coverImageUrl'] = coverImageUrl;
    // _data['dob'] = dob;
    // _data['gender'] = gender;
    // _data['lat'] = lat;
    // _data['lng'] = lng;
    _data['phone'] = phone;
    return _data;
  }
}
