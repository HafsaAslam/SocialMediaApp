import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia_app/controller/image_controller.dart';
import 'package:socialmedia_app/screens/welcom_page.dart';
import 'package:socialmedia_app/shared_prefrences.dart';
import 'dart:developer';
import 'dart:io';

import '../models/users_model.dart';
import '../widgets/text_container.dart';
//import '';

class UserProfileScreen extends StatelessWidget {
  final firebaseStorage = FirebaseStorage.instance;

  bool profile = true;

  UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(children: [
      GetBuilder<ProfileController>(
        init: ProfileController(),
        initState: (controller) {
          //controller.fetch
        },
        id: 'personalInfo',
        builder: (controller) {
          return controller.userModel != null
              ? Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        controller.userModel!.coverImageUrl != null
                            ? GestureDetector(
                                onTap: () {
                                  controller.profile = false;
                                  controller.showPicker(context);
                                },
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    controller.userModel!.coverImageUrl!,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 220, 231, 228)),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: IconButton(
                                    icon: Icon(Icons.camera_alt_outlined),
                                    iconSize: 55,
                                    onPressed: () async {
                                      controller.profile = false;
                                      controller.showPicker(context);
                                    })),
                        Align(
                            alignment: Alignment.bottomLeft,
                            heightFactor: 2.5,
                            //top: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                controller.userModel!.profileImageUrl != null
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.showPicker(context);
                                        },
                                        child: CircleAvatar(
                                          radius: 50,
                                          child: ClipOval(
                                            child: SizedBox(
                                              height: 100,
                                              child: Image.network(
                                                controller.userModel!
                                                    .profileImageUrl!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ))
                                    : Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 181, 189, 187),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 100,
                                        width: 100,
                                        child: IconButton(
                                            icon: const Icon(
                                                Icons.camera_alt_outlined),
                                            iconSize: 60,
                                            onPressed: () {
                                              //controller.profile = true;
                                              controller.showPicker(context);
                                            })),
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textConatainer(
                      color: Color(0xfffbb448),
                      heading: "Personal Information\n",
                      name: "Name:",
                      value: controller.userModel!.firstName,
                      name2: "\nEmail:",
                      value2: controller.userModel!.metadata.email,
                      name3: "\nPhone no:",
                      value3: controller.userModel!.metadata.phone,
                    ),
                  ],
                )
              : const Text('loading');
        },
      ),
      TextButton(
          onPressed: () {
            logOutUser();
            Get.to(() => WelcomeScreen());
          },
          child: const Text('LogOut'))
    ])));
  }
}
//InkWell(
// //       onTap: () {
// //         Navigator.pop(context);
// //       },
// //       child: Container(
// //         padding: EdgeInsets.symmetric(horizontal: 10),
// //         child: Row(
// //           children: <Widget>[
// //             Container(
// //               padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
// //               child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
// //             ),
// //             Text('Back',
// //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
// //           ],
// //         ),
// //       ),
// //     );