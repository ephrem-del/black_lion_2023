import 'package:flutter/material.dart';

class SignupScreenModel {
  TextEditingController? phoneNumberController;
  TextEditingController? passwordController;
  bool loading = false;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  Future<bool> createAccount() {
    return Future.delayed(Duration(seconds: 1), () {
      return true;
    });
  }
}
