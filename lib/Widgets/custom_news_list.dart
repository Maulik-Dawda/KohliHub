import 'package:flutter/material.dart';

class CustomNewsList extends StatelessWidget {
  final String imageUrl;
  const CustomNewsList({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ClipPath(
      clipper: DiagonalClipper(),
      child: Container(
        width: screenWidth * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: NetworkImage(imageUrl), // your image
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.all(8),
            width: screenWidth * 0.1,
            height: screenHeight * 0.04,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.3); // start lower on the left
    path.lineTo(size.width, 0); // slant up to top-right
    path.lineTo(size.width, size.height); // right-down
    path.lineTo(0, size.height); // left-down
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DiagonalClipper oldClipper) => false;
}
