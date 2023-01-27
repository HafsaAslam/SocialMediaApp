import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Heading extends StatefulWidget {
  final Color color;
  final Color color1;

  const Heading({
    super.key,
    required this.color,
    required this.color1,
  });

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "so",
          style: GoogleFonts.portLligatSans(
              color: widget.color, fontWeight: FontWeight.bold, fontSize: 30),
          children: [
            TextSpan(
                text: "cialM",
                style: TextStyle(color: Colors.black, fontSize: 30)),
            TextSpan(
                text: "edia\n",
                style: TextStyle(color: widget.color1, fontSize: 30)),
            TextSpan(
                text: "                      connect with people",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                )),
          ]),
    );
  }
}
