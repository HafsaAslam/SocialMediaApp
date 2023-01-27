import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia_app/screens/post/post_with_comment.dart';

import '../../controller/post_controller.dart';
import '../../models/post_model.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //List<PostModel> postList = [];
    return Scaffold(
        body: ListView(padding: EdgeInsets.all(15), children: [
      GetBuilder<PostController>(
          init: PostController(),
          initState: (controller) {},
          id: 'userInfo',
          builder: (controller) {
            return Row(children: [
              SizedBox(
                height: 40,
                width: 40,
                child: CircleAvatar(
                    child: ClipOval(
                        child: controller.userImage != null
                            ? Image.network(controller.userImage!)
                            : Icon(Icons.person))),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black54,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 1.3, color: Colors.grey),
                  ),
                  hintText: "What's on your mind?",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 1.3, color: Colors.grey),
                  ),
                ),
              )),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.photo_library,
                  size: 30,
                ),
              )
            ]);
          }),
      SizedBox(
        height: 10,
      ),

      ///show all posts
      GetBuilder<PostController>(
          init: PostController(),
          initState: (controller) {},
          id: 'postInfo',
          builder: (controller) {
            return FutureBuilder(
                future: controller.fetchPost(),
                builder: ((context, snapshot) {
                  return controller.dataModel.isNotEmpty
                      ? ListView.separated(
                          itemCount: controller.dataModel.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(children: [
                              ListTile(
                                leading: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircleAvatar(
                                      child: ClipOval(
                                          child:
                                              // ignore: unnecessary_null_comparison
                                              controller.dataModel[index]
                                                          .userImage !=
                                                      null
                                                  ? Image.network(controller
                                                      .dataModel[index]
                                                      .userImage)
                                                  : Icon(Icons.person)),
                                    )),
                                title:
                                    Text(controller.dataModel[index].userName),
                                subtitle:
                                    Text(controller.dataModel[index].dateTime),
                                trailing: Icon(Icons.share),
                              ),
                              controller.dataModel[index].postText != null
                                  ? Text(controller.dataModel[index].postText)
                                  : Text(''),
                              controller.dataModel[index].postImage != null
                                  ? SizedBox(
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        controller.dataModel[index].postImage!,
                                        fit: BoxFit.cover,
                                      ))
                                  : Text(''),
                              Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.thumb_up_alt)),
                                          TextButton(
                                              onPressed: () {
                                                Get.to(PostWithComment(
                                                    post: controller
                                                        .dataModel[index]));
                                              },
                                              child: Text("comments")),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [Text("12 comments")],
                                      )
                                    ],
                                  ))
                            ]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 10,
                              color: Colors.grey,
                            );
                          })
                      : const Text('loading');
                }));
          }),
    ]));
  }
}
