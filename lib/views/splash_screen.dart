import 'package:black_lion_2023/service/image_service.dart';
import 'package:black_lion_2023/views/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  isLoggedIn() {
    final result = false;
    if (result) {
      navigateToHomeScreen();
    } else {
      navigateToLoginScreen();
    }
  }

  navigateToLoginScreen(){
    Future.delayed(Duration(seconds: 3), () {
      Get.to(
        () => LoginScreen(),
      );
    });    
  }

  navigateToHomeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Get.to(
        () => HomeScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageService.logo,
              height: 200,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
