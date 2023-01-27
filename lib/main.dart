import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia_app/screens/home_screen.dart';
import 'package:socialmedia_app/screens/login_screen.dart';
import 'package:socialmedia_app/screens/sign_up_screen.dart';
import 'package:socialmedia_app/screens/user_profile_screen.dart';
import 'package:socialmedia_app/screens/welcom_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //s options: defaultFirebaseAppName.
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: true, home: WelcomeScreen());
  }
}
