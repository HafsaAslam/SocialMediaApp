import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:socialmedia_app/screens/home_screen.dart';
import 'package:socialmedia_app/screens/home_screenn.dart';
import 'package:socialmedia_app/screens/login_screen.dart';
import 'package:socialmedia_app/screens/user_profile_screen.dart';
import 'package:socialmedia_app/widgets/customaized_label.dart';
import 'package:socialmedia_app/widgets/social_media_heading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../auth/firebase_auth.dart';
import '../widgets/customaized_button.dart';
import '../widgets/password_feild.dart';
import '../widgets/text_from_feild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBar(
        //   actions: [],
        // ),
        body: Form(
      key: _formkey,
      child: Container(
          height: height,
          child: Stack(
            //sclipBehavior: Clip.none,
            children: [
              Positioned(
                  right: -20,
                  top: -MediaQuery.of(context).size.height * .50,
                  child: Image(image: AssetImage('assets/images/stack.png'))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    SizedBox(
                      height: height * .25,
                    ),
                    Heading(color: Colors.black, color1: Colors.black),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFeild(
                      text: "Name",
                      controller: namecontroller,
                      hintText: "Alexa",
                      validator: (String? input) {
                        if (input == null || input.isEmpty) {
                          return "Please type your Name";
                        }
                        //else if (input.length < 6) {
                        //     return "Please enter 6 digits.";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFeild(
                        text: "Email",
                        controller: emailcontroller,
                        hintText: "email123@gmail.com",
                        validator: (value) {
                          Pattern pattern =
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              r"{0,253}[a-zA-Z0-9])?)*$";
                          RegExp regex = RegExp(pattern.toString());
                          if (value == null) {
                            return 'Enter an Email Address!';
                          } else if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        }),

                    SizedBox(
                      height: 8,
                    ),
                    PasswordFeild(
                      controller: passwordcontroller,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextFeild(
                      text: "Phone no",
                      controller: phonecontroller,
                      hintText: "03458899399",
                      validator: (String? input) {
                        if (input == null || input.isEmpty) {
                          return "Please type your phone no";
                        } else if (input.length < 11) {
                          return "Please enter correct name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomaizedButton(
                      onpress: () async {
                        if (_formkey.currentState!.validate()) {
                          await Auth.signupUser(
                              email: emailcontroller.text,
                              firstName: namecontroller.text,
                              password: passwordcontroller.text,
                              phoneno: phonecontroller.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      },
                      text: "SignUp",
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Label(
                        text: 'Already have an account?',
                        colorText: 'Login',
                        pageToShow: LogInScreen()),
                    //Flexible(child: Center()),
                  ],
                ),
              ),
              Positioned(top: 40, left: 0, child: Icon(Icons.arrow_back)),
              //return InkWell(
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
            ],
          )),
    ));
  }

  // Future<bool> signUpUser({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phoneno,
  // }) async {
  //   bool status = false;
  //   try {
  //     status = true;
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     User? currentUser = credential.user;
  //     if (currentUser != null) {
  //       Map<String, dynamic> userMetaData = {
  //         "phone": phoneno,
  //         "email": email,
  //         "gender": "",
  //         "education": "",
  //       };
  //       await FirebaseChatCore.instance.createUserInFirestore(
  //         types.User(
  //             firstName: name,
  //             id: credential.user!.uid,
  //             imageUrl: 'https://i.pravatar.cc/300?u=$email',
  //             lastName: name,
  //             metadata: userMetaData),
  //       );
  //       // DocumentReference currentUserReference =
  //       //     userReference.doc(currentUser.uid);
  //       // Map<String, dynamic> userProfileData = {
  //       //   "name": fullName.capitalize,
  //       //   "password": password,
  //       //   "phone": phoneNo,
  //       //   "email": email,
  //       //   "uid": currentUser.uid,
  //       // };
  //       // await currentUserReference.set(userProfileData);
  //     }
  //     status = true;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       debugPrint('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       debugPrint('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //   return status;
  // }
}
