import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:socialmedia_app/shared_prefrences.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../models/users_model.dart';

class Auth {
  static CollectionReference userReference =
      FirebaseFirestore.instance.collection("users");
  static Future<bool> signupUser({
    required String email,
    required String firstName,
    required String password,
    required String phoneno,
  }) async {
    bool status = false;
    try {
      status = true;
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? currentUser = credential.user;
      if (currentUser != null) {
        // DocumentReference currentUserReference =
        //     userReference.doc(currentUser.uid);
        // Map<String, dynamic> userProfileData = {
        //   "firstName": firstName,
        //   "phone": phoneno,
        //   "email": email,
        //   "uid": currentUser.uid
        // };
        // currentUserReference.set(userProfileData);
        Map<String, dynamic> userMetaData = {
          "phone": phoneno,
          "email": email,
          "uid": currentUser.uid,
          "password": password
          // "gender": "",
          // "education": "",
        };
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
              firstName: firstName,
              id: credential.user!.uid,

              //id: currentUser.uid,
              imageUrl: 'https://i.pravatar.cc/300?u=$email',
              lastName: firstName,
              metadata: userMetaData),
        );
      }

      status = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return status;
  }

/////////////login///////////////

  static Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    bool status = false;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //ignore: unused_local_variable
      User? currentUser = credential.user;
      var collection = FirebaseFirestore.instance.collection('users');
      String uidd = FirebaseAuth.instance.currentUser!.uid;
      var docSnapshot = await collection.doc(uidd).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        if (data != null) {
          UserModelFireBase userModel = UserModelFireBase.fromJson(data, uidd);

          setUserDetails(
              uid: userModel.metadata.uid,
              firstName: userModel.firstName,
              email: userModel.metadata.email,
              profileImageUrl: userModel.profileImageUrl);
        }
      }
      status = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return status;
  }
}
