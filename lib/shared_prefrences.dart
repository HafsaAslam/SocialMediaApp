import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUserDetails({
  required String uid,
  required String firstName,
  required String email,
  String? profileImageUrl,
}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  log("setting user uid : $uid");
  preferences.setString("uid", uid);
  log("setting user firstName : $firstName");
  preferences.setString("firstName", firstName);
  log("setting user email : $email");
  preferences.setString("email", email);
  if (profileImageUrl != null) {
    log("setting user profileImageUrl : $profileImageUrl");
    preferences.setString("profileImageUrl", profileImageUrl);
  }
}

Future<String> getUseruid() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString("uid") == null) {
    log("null user uid");
    return "";
  }
  log('getting uid: Successfully');
  log('${preferences.getString("firstName").toString()}');
  return preferences.getString("uid").toString();
}

Future<String> getUserfirstName() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString("firstName") == null) {
    log("null user firstName");
    return "";
  }
  log('getting firstName: Successfully');
  log('${preferences.getString("firstName").toString()}');
  return preferences.getString("firstName").toString();
}

Future<String> getUserEmail() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString("email") == null) {
    log("null user email");
    return "";
  }
  log('getting email: Successfully');

  return preferences.getString("email").toString();
}

Future<String?> getUserImage() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  log('getting profileImageUrl: Successfully, ');
  log('${preferences.getString("profileImageUrl")}');
  return preferences.getString("profileImageUrl");
}

logOutUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('uid');
  preferences.remove('email');
  preferences.remove('firstName');
  preferences.remove('profileImageUrl');
}
