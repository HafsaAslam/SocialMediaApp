import 'package:flutter/material.dart';

class textConatainer extends StatefulWidget {
  final String? heading;
  final String name;
  final String value;
  final String? name1;
  final String? value1;
  final String? name2;
  final String? value2;
  // final IconData? icon;
  //final Widget? textName;
  final String? name3;
  final String? value3;
  final String? name4;
  final String? value4;
  final bool isButton;
  final Color? color;
  //final Widget? pageToShow;

  const textConatainer({
    super.key,
    this.heading,
    this.color = Colors.amber,
    required this.name,
    required this.value,
    this.name1,
    this.value1,
    this.name2,
    this.value2,
    this.name3,
    this.value3,
    this.isButton = false,
    this.name4,
    this.value4,
    // this.icon,
    // required this.textName,
    // this.pageToShow})
    // : assert(pageToShow != null);
  });
  @override
  State<textConatainer> createState() => _textConatainerState();
}

class _textConatainerState extends State<textConatainer> {
  //bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.color,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: widget.heading,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                  text: widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: widget.value),
              TextSpan(
                  text: widget.name1,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: widget.value1),
              TextSpan(
                  text: widget.name2,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: widget.value2),
              TextSpan(
                  text: widget.name3,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: widget.value3),
              TextSpan(
                  text: widget.name4,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: widget.value4),
            ])),
            // widget.isButton
            //     ? Align(
            //         alignment: Alignment.bottomRight,
            //         child: OutlinedButton.icon(
            //           onPressed: () {
            //             Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => widget.pageToShow));
            //           },
            //           style: OutlinedButton.styleFrom(
            //               backgroundColor: Color(0xFFD19D00),
            //               primary: Colors.white),
            //           icon: Icon(widget.icon),
            //           label: Text(widget.textName),
            //         ))
            //     : Container()
          ],
        ),
      ),
    );
  }
}
