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
        if (student == null) {
          navigateToLoginScreen();
          return;
        }
        navigateToHomeScreen(student);
      }
    }
  }

  Future<Student?> getStudent(String email) async {
    try {
      final db = FirebaseFirestore.instance;
      var result = await db.collection('students').doc(email).get();
      if (!result.exists) return null;
      final Student student = Student.fromMap(result);
      
      return student;
    } on FirebaseException {
      return null;
    }
  }

  navigateToLoginScreen() {
    Future.delayed(Duration(seconds: 4), () {
      Get.off(
        () => LoginScreen(),
      );
    });
  }

  navigateToHomeScreen(Student student) {
    Future.delayed(Duration(seconds: 4), () {
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
              height: 20,
            ),

            CircularProgressIndicator(),
            SizedBox(height: 40),
            Text('Developed by'),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'DEMAKK ADVERTISING',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'AND DIGITAL SOLUTIONS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '0925565768',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '0922493805',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
