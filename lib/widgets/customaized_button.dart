import 'package:flutter/material.dart';

class CustomaizedButton extends StatefulWidget {
  final String text;
  final VoidCallback onpress;
  const CustomaizedButton(
      {super.key, required this.text, required this.onpress});

  @override
  State<CustomaizedButton> createState() => _CustomaizedButtonState();
}

class _CustomaizedButtonState extends State<CustomaizedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 48,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Color(0xffe46b10), Color(0xfffbb448)])),
          child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
