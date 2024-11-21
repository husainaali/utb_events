import 'package:flutter/material.dart';
import 'package:utb_events/utils/size_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor =
        const Color(0xFFBE3144), // The red color from your image
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: ClipPath(
        clipper: CustomShapeClipper(),
        child: Container(
          color: backgroundColor,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left
    path.lineTo(0, size.height - 40);

    // Create the curved bottom
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 40);

    // Complete the shape
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
