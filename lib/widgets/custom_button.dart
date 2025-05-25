import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.ontap, required this.text});
  String text;
  VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(
              color: Color(0xff274460),
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
