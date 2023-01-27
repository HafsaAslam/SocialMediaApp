import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/post_controller.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<PostController>(
              init: PostController(),
              initState: (controller) {
                //scontroller.
              },
              id: 'userInfo',
              builder: (controller) {
                return ListView(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back,
                              size: 25,
                            )),
                        Text(
                          'Create Post',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            child: ClipOval(
                                child: controller.userImage != null
                                    ? Image.network(controller.userImage!)
                                    : Icon(
                                        Icons.person,
                                      )),
                          )),
                      title: Text(
                        controller.userName,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      subtitle: Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.people,
                              size: 24.0,
                              color: Colors.black,
                            ),
                            label: Text(
                              'Friends',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add,
                                size: 24.0, color: Colors.black),
                            label: Text('Album',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                      //isThreeLine: true,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: SizedBox(
                        height: 200,
                        //width: 20,
                        child: TextFormField(
                          //maxLength: max(a, b),
                          maxLines: 80,
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: controller.bodyController,
                        ),
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       controller.showPicker(context);
                    //     },
                    //     icon: Icon(Icons.image)),
                    GestureDetector(
                      onTap: () {
                        controller.showPicker(context);
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey,
                          child: controller.imageFile != null
                              ? Image.file(
                                  controller.imageFile!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.camera)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          controller.addPost();
                        },
                        child: Text("add Post"))
                  ],
                );
              })),
    );
  }
}
