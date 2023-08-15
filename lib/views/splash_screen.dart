import 'package:black_lion_2023/service/image_service.dart';
import 'package:black_lion_2023/views/login_screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/students.dart';
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

  isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn == null || isLoggedIn == false) {
      navigateToLoginScreen();
    } else {
      final email = prefs.getString('email');
      if (email == null) {
        navigateToLoginScreen();
      } else {
        final student = await getStudent(email);
        navigateToHomeScreen(student);
      }
    }
  }

  Future<Student> getStudent(String email) async {
    final db = FirebaseFirestore.instance;
    final result = await db.collection('students').doc(email).get();
    final Student student = Student.fromMap(result);
    return student;
  }

  navigateToLoginScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(
        () => LoginScreen(),
      );
    });
  }

  navigateToHomeScreen(Student student) {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(
        () => HomeScreen(
          student: student,
        ),
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
