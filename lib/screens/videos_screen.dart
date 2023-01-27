import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.all(15), children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Videos',
                style: GoogleFonts.portLligatSans(
                    fontWeight: FontWeight.w600, fontSize: 30),
              ),
            ),
            Icon(
              Icons.search,
              size: 30,
            )
          ],
        )
      ]),
    );
  }
}
