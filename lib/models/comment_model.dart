class CommentModel {
  CommentModel({
    required this.uid,
    required this.id,
    required this.comment,
  });

  late final String uid;
  late final String id;
  late final String comment;

  CommentModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? "";
    id = json['id'] ?? "";
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['id'] = id;
    _data['comment'] = comment;

    return _data;
  }
}
