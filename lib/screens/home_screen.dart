// import 'package:flutter/material.dart';
// import 'package:socialmedia_app/screens/add_post_screen.dart';
// import 'package:socialmedia_app/screens/post_screen.dart';
// import 'package:socialmedia_app/screens/user_profile_screen.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.bottomRight,
//                   end: Alignment.topLeft,
//                   colors: [Color(0xfffbb448), Color(0xffe46b10)])),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => UserProfileScreen(),
//                   ));
//             },
//             icon: Icon(
//               Icons.person,
//               size: 30,
//             ),
//           )
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(children: [
//           UserAccountsDrawerHeader(
//             accountName: Text("Name"),
//             accountEmail: Text("email"),
//             currentAccountPicture: (Container()),
//             otherAccountsPictures: [],
//           ),
//           ListTile(
//             title: Text("User Profile"),
//             leading: Icon(Icons.person),
//             onTap: () {
//               Get.to(UserProfileScreen());
//             },
//           ),
//           ListTile(
//             title: Text("Add Post"),
//             leading: Icon(Icons.add),
//             onTap: () {
//               Get.to(() => AddPostScreen());
//             },
//           ),
//         ]),
//       ),
//       body: ListView.separated(
//           itemCount: 20,
//           itemBuilder: (context, index) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child:
//                       Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                         ListTile(
//                           leading: SizedBox(
//                               height: 40,
//                               width: 40,
//                               child:
//                                   CircleAvatar(backgroundColor: Colors.blue)),
//                           title: Text("Name"),
//                           subtitle: Text("12 mint"),
//                           trailing: Icon(Icons.share),
//                         ),
//                         const Text(
//                             "CircleAvatar widget comes built-in with the flutter SDK. It is simply a circle in which we can add background color, background image, or just some text. It usually represents a user with his image or with his initials. Although we can make a similar widget from the ground up, this widget comes in handy in the fast development of an application"),
//                       ]),
//                 ),
//                 SizedBox(
//                   height: 150,
//                   width: MediaQuery.of(context).size.width,
//                   child: Image.network(
//                     "https://www.designbolts.com/wp-content/uploads/2012/07/Beautiful-Love-Facebook-Cover-Photo1.jpg",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                               onPressed: () {}, icon: Icon(Icons.thumb_up_alt)),
//                           TextButton(onPressed: () {}, child: Text("comments")),
//                         ],
//                       ),
//                       Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [Text("12 comments")],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               height: 10,
//               color: Colors.grey,
//             );
//           }),
//     );
//   }
// }
