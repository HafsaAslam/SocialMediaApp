import 'package:flutter/material.dart';

class PasswordFeild extends StatefulWidget {
  //final String? Function(String?)? validator;
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;
  const PasswordFeild({
    super.key,
    required this.controller,
    this.autovalidateMode,
    //required this.validator,
  });

  @override
  State<PasswordFeild> createState() => _PasswordFeildState();
}

class _PasswordFeildState extends State<PasswordFeild> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: widget.autovalidateMode,
        controller: widget.controller,
        validator: (String? input) {
          if (input == null || input.isEmpty) {
            return "Please type your password.";
          } else if (input.length < 6) {
            return "Please enter 6 digits.";
          }
          return null;
        },
        obscureText: isHidden,
        //validator: widget.validator,
        // obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.black54,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 1.3, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 1.3, color: Colors.grey),
          ),
          suffixIcon: InkWell(
            onTap: () => setState(() {
              isHidden = !isHidden;
            }),
            child: Icon(
              isHidden ? Icons.visibility : Icons.visibility_off,
              // color: Colors.grey.shade300,
            ),
          ),
        ));
  }
}
