import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia_app/screens/post/add_post_screen.dart';
import 'package:socialmedia_app/screens/chat/rooms.dart';
import 'package:socialmedia_app/screens/friend_request_screen.dart';
import 'package:socialmedia_app/screens/notification_screen.dart';
import 'package:socialmedia_app/screens/post/post_screen.dart';
import 'package:socialmedia_app/screens/user_profile_screen.dart';
import 'package:socialmedia_app/screens/videos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(78),
          child: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xfffbb448), Color(0xffe46b10)]))),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => AddPostScreen());
                  },
                  icon: Icon(Icons.add)),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Get.to(() => RoomsPage());
                  },
                  icon: Icon(Icons.message_rounded))
            ],
            title: const Text(
              "SocialMedia App",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            bottom: const TabBar(

                //unselectedLabelStyle: Colors.green,
                //indicatorWeight: 0.25,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                  ),
                  Tab(icon: Icon(Icons.video_collection)),
                  Tab(icon: Icon(Icons.notifications)),
                  Tab(icon: Icon(Icons.person)),
                ]),
          ),
        ),
        body: TabBarView(children: [
          PostScreen(),
          FriendRequestScreen(),
          VideosScreen(),
          NotificationScreen(),
          UserProfileScreen(),
        ]),
      ),
    );
  }
}
