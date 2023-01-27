import 'dart:async';

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia_app/screens/home_screen.dart';
import 'package:socialmedia_app/screens/home_screenn.dart';
import 'package:socialmedia_app/screens/login_screen.dart';
import 'package:socialmedia_app/screens/sign_up_screen.dart';
import 'package:socialmedia_app/widgets/social_media_heading.dart';

import '../shared_prefrences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), checkFirst);

    // TODO: implement initState
    super.initState();
  }

  checkFirst() async {
    String uid = await getUseruid();
    if (uid.isNotEmpty) {
      Get.off(() => const HomeScreen());
    } else {
      Get.off(() => const LogInScreen());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfffbb448), Color(0xffe46b10)])),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Heading(
              color: Colors.white,
              color1: Colors.white,
            ),
            const SizedBox(
              height: 80,
            ),
            //loginbutton
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogInScreen(),
                    ));
              },
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Color(0xffe46b10), fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //signup
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ));
              },
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Colors.white),
                ),
                child: const Text(
                  "Register Now",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ]),
    ));
  }
}
