import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final FontWeight fontWeight;
  final bool underline;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.underline = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
