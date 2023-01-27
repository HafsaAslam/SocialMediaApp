import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:socialmedia_app/shared_prefrences.dart';

import '../models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socialmedia_app/models/users_model.dart';

import '../models/post_model.dart';

class PostController extends GetxController {
  TextEditingController bodyController = TextEditingController();
  //PostModel? postModel;

  UserModelFireBase? userModel;
  List<PostModel> dataModel = [];
  String userName = '';
  String? userImage;
  CollectionReference userRefrence =
      FirebaseFirestore.instance.collection("post");
  User? user = FirebaseAuth.instance.currentUser;
  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();

  get firebaseStorage => null;

  addPost(
      //   {
      //   required TextEditingController? postText,
      // }
      ) async {
    CollectionReference postReference =
        FirebaseFirestore.instance.collection('post');
    User? user = FirebaseAuth.instance.currentUser;
    String uid = "";

    if (user != null) {
      uid = user.uid;
    }
    log(uid);

    String body = bodyController.text;
    // String? userimage = userModel.profileImageUrl;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMEd().format(now);
    print(formattedDate);
    var doc = FirebaseFirestore.instance.collection('post');
    var postImage = await uploadPhoto(file: File(imageFile!.path));
    //s var postImage = await uploadImage();

    final data = {
      'postText': body,
      'uid': uid,
      'dateTime': formattedDate,
      'userImage': userImage,
      'userName': userImage,
      'postImage': postImage,
    };
    await doc
        .add(data)
        .then((value) => Get.snackbar(
              'Add Post Successfully',
              '',
            ))
        .catchError(
          (value) => print(value),
        );

    fetchPost();
  }

  Future<void> fetchPost() async {
    String body = bodyController.text;
    //String userimage = userModel.profileImageUrl!;
    FirebaseFirestore.instance.collection('post').get().then((value) {
      for (var result in value.docs) {
        log("dataEntry = ${result.data().toString()}");

        dataModel.add(PostModel.fromJson(result.data(), result.id));
      }
      update(['postInfo']);
    });
  }

  Future<void> fetchPersonalData() async {
    userName = await getUserfirstName();
    log(userName);
    userImage = await getUserImage();

    update(['userInfo']);
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                    leading: const Icon(Icons.camera_alt, color: Colors.blue),
                    title: const Text('Capture Now'),
                    onTap: () {
                      imgFromCamera(context);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.image, color: Colors.blue),
                  title: const Text('Pick from Gallery'),
                  onTap: () {
                    imgFromGallery(context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  imgFromCamera(BuildContext context) async {
    XFile? image = await ImagePicker.platform
        .getImage(source: ImageSource.camera, imageQuality: 30) as XFile;
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedFile != null) {
        imageFile = File(croppedFile.path);
        log("image selected");
      }
    }
  }

  imgFromGallery(BuildContext context) async {
    final XFile? selectedImage = await imagePicker.pickImage(
        imageQuality: 70, source: ImageSource.gallery);
    if (selectedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: selectedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        imageFile = File(croppedFile.path);
        log("image selected");
      }
    }
  }

  uploadPhoto({required File file}) async {
    int uploadTimestamp = DateTime.now().millisecondsSinceEpoch;
    // Reference ref = firebaseStorage.ref().child('Images/$uploadTimestamp');
    final ref = FirebaseStorage.instance.ref().child("Images/$uploadTimestamp");
    UploadTask uploadTask = ref.putFile(file);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    log('image url: $downloadUrl');

    return downloadUrl;
  }

  void onInit() {
    super.onInit();

    fetchPost();
  }

  // uploadImage() async {
  //   File file = File(imageFile!.path);

  //   int uploadTimestamp = DateTime.now().millisecondsSinceEpoch;
  //   // Reference ref = firebaseStorage.ref().child('Images/$uploadTimestamp');
  //   final ref = FirebaseStorage.instance.ref().child("Images/$uploadTimestamp");

  //   try {
  //     UploadTask uploadTask = ref.putFile(file);
  //     var downloadUrl = await (await uploadTask).ref.getDownloadURL();
  //     log('image url: $downloadUrl');

  //     final fireStore = FirebaseFirestore.instance;

  //     var data = {'postImage': downloadUrl.toString()};

  //     await fireStore.collection('post');
  //   } on Exception catch (e) {
  //     log(e.toString());
  //   }

  //   imageFile = null;
  //   //_image = null;
  //   fetchPost();
  // }
}
