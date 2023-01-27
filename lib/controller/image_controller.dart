import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'dart:io';

import '../models/users_model.dart';

class ProfileController extends GetxController {
  UserModelFireBase? userModel;
  CollectionReference userRefrence =
      FirebaseFirestore.instance.collection("users");
  User? user = FirebaseAuth.instance.currentUser;

  bool profile = true;
  XFile? _image;
  File? imageFile;
  final ImagePicker imagePicker = ImagePicker();
  final firebaseStorage = FirebaseStorage.instance;

  uploadPhoto({required File file}) async {
    int uploadTimestamp = DateTime.now().millisecondsSinceEpoch;
    Reference ref = firebaseStorage.ref().child('Images/$uploadTimestamp');

    UploadTask uploadTask = ref.putFile(file);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    log('image url: $downloadUrl');

    return downloadUrl;
  }

  uploadImage() async {
    var downloadUrl = await uploadPhoto(file: File(imageFile!.path));

    try {
      final fireStore = FirebaseFirestore.instance;

      var data = profile
          ? {'profileImageUrl': downloadUrl.toString()}
          : {'coverImageUrl': downloadUrl.toString()};
      String uidd = FirebaseAuth.instance.currentUser!.uid;
      await fireStore.collection('users').doc(uidd).update(data);
    } on Exception catch (e) {
      log(e.toString());
    }

    imageFile = null;
    _image = null;
    fetchPersonalData();
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
      uploadImage();
    }
    // setState(() {});
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
      uploadImage();
      //setState(() {});
    }
  }

  Future<void> fetchPersonalData() async {
    var collection = FirebaseFirestore.instance.collection('users');
    String uidd = FirebaseAuth.instance.currentUser!.uid;
    var docSnapshot = await collection.doc(uidd).get();
    if (docSnapshot.exists) {
      //Map<String, dynamic>? data = docSnapshot.data();
      // if (data != null) {
      log(docSnapshot.toString());
      // userModel = UserModelFireBase.fromJson(data, uidd);
      userModel = UserModelFireBase.fromDocumentSnapshot(docSnapshot);
      update(['personalInfo']);

      //setState(() {});
      // }
    }
  }

  void onInit() {
    super.onInit();
    fetchPersonalData();
  }
}
//myUid = user!.uid;

