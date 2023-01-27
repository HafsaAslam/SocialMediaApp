import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/comment_model.dart';
import '../../models/post_model.dart';

class PostWithComment extends StatefulWidget {
  final PostModel post;

  const PostWithComment({
    super.key,
    required this.post,
  });

  @override
  State<PostWithComment> createState() => _PostWithCommentState();
}

class _PostWithCommentState extends State<PostWithComment> {
  TextEditingController commentCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<CommentModel> dataModel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 155, 196, 215),
            ),
            child: ListTile(
              title: Text(widget.post.userName),
              subtitle: Text(widget.post.postText),
            ),
          ),
          dataModel.isNotEmpty
              ? ListView.builder(
                  itemCount: dataModel.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = dataModel[index];
                    return Text(item.comment);
                  },
                )
              : const SizedBox(),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: commentCont,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter comment';
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Comment'),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                saveComment();
              }
            },
            child: const Text('Add Comment'),
          )
        ],
      ),
    );
  }

  void saveComment() async {
    String com = commentCont.text;
    String postId = widget.post.id;

    var doc =
        FirebaseFirestore.instance.collection('post/$postId/Comments').doc();

    final data = {
      'comment': com,
      'uid': widget.post.uid,
      'id': doc.id,
      'postId': postId
    };

    await doc.set(data);

    fetchComments();
  }

  void fetchComments() async {
    String com = commentCont.text;
    String postId = widget.post.id;

    FirebaseFirestore.instance
        .collection("post/$postId/Comments")
        .get()
        .then((value) {
      for (var result in value.docs) {
        log("data = ${result.data().toString()}");

        dataModel.add(CommentModel.fromJson(result.data()));
      }
      setState(() {});
    });
  }
}
