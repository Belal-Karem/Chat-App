import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {this.onChanged,
      this.hinttext,
      this.obscureText = false,
      this.suffixIcon});

  String? hinttext;
  Function(String)? onChanged;
  bool obscureText;
  IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Fiald is required';
        }
      },
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: '$hinttext',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
