import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Opacity(
        opacity: 0.6,
        child: Image.asset(
          fit: BoxFit.fitHeight,
          'assets/images/background1.jpeg',
        ),
      ),
    );
  }
}
