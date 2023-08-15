import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../service/logger.dart';

class SignupScreenModel {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool loading = false;
  int? resendTokenVariable;
  String errorText = '';
  int? otp;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createAccount() async {
    final email = emailController!.text;
    final password = passwordController!.text;
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      logger.i('user credential: $credential');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorText = 'weak password please change it';
        logger.e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorText = 'The account already exists for that email';
        logger.e('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      errorText = 'Some error occured please try again later';
      logger.e('error: $e');
      return false;
    }
  }

  Future<bool> resendCode() async {
    return Future.delayed(Duration(seconds: 1), () {
      return true;
    });
  }
}
