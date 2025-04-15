// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  VoidCallback? onPressed;
  EdgeInsets? padding;
  String? text;
  Color? backgroundColor;
  double? width;
  CustomButton({
    super.key,
    required this.onPressed,
    this.padding,
    required this.text,
    this.backgroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent, // remove shadow
          surfaceTintColor: Colors.transparent, // optional for newer versions
          elevation: 0, // remove elevation if needed
        ),
        child: Text(
          text ?? 'Click Me',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
