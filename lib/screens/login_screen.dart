import 'package:flutter/material.dart';
import 'package:socialmedia_app/screens/home_screen.dart';
import 'package:socialmedia_app/screens/home_screenn.dart';
import 'package:socialmedia_app/screens/sign_up_screen.dart';
import 'package:socialmedia_app/screens/user_profile_screen.dart';
import 'package:socialmedia_app/widgets/customaized_label.dart';
import 'package:socialmedia_app/widgets/social_media_heading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/firebase_auth.dart';
import '../widgets/customaized_button.dart';
import '../widgets/password_feild.dart';
import '../widgets/text_from_feild.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * .25,
                      ),
                      Heading(color: Colors.black, color1: Colors.black),
                      SizedBox(
                        height: 15,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordcontroller,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              "Forget your password?",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomaizedButton(
                        onpress: () async {
                          if (_formkey.currentState!.validate()) {
                            bool loggedIn = await Auth.loginUser(
                                email: emailcontroller.text,
                                password: passwordcontroller.text);

                            if (loggedIn) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Login Failed')));
                            }
                          }
                        },
                        text: "LogIn",
                      ),
                      // Text("Login with social", textAlign: TextAlign.center),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     // Text("Login with social", textAlign: TextAlign.center),
                      //     IconButton(
                      //         onPressed: () {}, icon: Icon(Icons.facebook)),
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: Icon(FontAwesomeIcons.google),
                      //     )
                      //   ],
                      // ),

                      Label(
                          text: 'Don\'t have an account ?',
                          colorText: 'Register',
                          pageToShow: SignUpScreen()),
                      Flexible(child: Center()),
                    ],
                  ),
                ),
                Positioned(top: 40, left: 0, child: Icon(Icons.arrow_back)),
              ],
            )),
      ),
    );
  }
}
