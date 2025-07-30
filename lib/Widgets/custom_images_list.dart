import 'package:flutter/material.dart';

class CustomImagesList extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  const CustomImagesList({super.key, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: onTap,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
