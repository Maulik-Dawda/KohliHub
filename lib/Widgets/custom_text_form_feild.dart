import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFromTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData leadingIcon;
  final String nameText;
  final String hintText;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomFromTextField({
    super.key,
    required this.controller,
    required this.leadingIcon,
    required this.nameText,
    required this.hintText,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nameText, style:  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.white)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(leadingIcon),
            suffixIcon: trailingIcon != null
                ? IconButton(
              icon: Icon(trailingIcon),
              onPressed: onTrailingIconPressed,
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
