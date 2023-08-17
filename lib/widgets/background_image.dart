import 'package:black_lion_2023/service/image_service.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

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
              'assets/images/background1.jpeg',
            ),
          ),
        ),
      ],
    );
  }
}
