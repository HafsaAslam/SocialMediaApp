import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia_app/shared_prefrences.dart';

class FriendRequestScreen extends StatelessWidget {
  const FriendRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.all(15), children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Friends',
                style: GoogleFonts.portLligatSans(
                    fontWeight: FontWeight.w600, fontSize: 30),
              ),
            ),
            Icon(
              Icons.search,
              size: 30,
            )
          ],
        ),
        IconButton(
            onPressed: () {
              getUseruid();
            },
            icon: Icon(Icons.apartment)),
        IconButton(
            onPressed: () {
              getUserfirstName();
            },
            icon: Icon(Icons.apartment)),
        IconButton(
            onPressed: () {
              getUserEmail();
            },
            icon: Icon(Icons.apartment)),
      ]),
    );
  }
}
