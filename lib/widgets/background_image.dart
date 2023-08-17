import 'package:black_lion_2023/service/image_service.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final int image;
  const BackgroundImage({super.key, required this.image});

  String selectImage() {
    if (image == 1) {
      return 'assets/images/background1.jpeg';
    } else if (image == 2) {
      return 'assets/images/background2.jpeg';
    } else {
      return 'assets/images/background1.jpeg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              ImageService.logo,
            ),
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              fit: BoxFit.fitHeight,
              selectImage(),
            ),
          ),
        ),
      ],
    );
  }
}
