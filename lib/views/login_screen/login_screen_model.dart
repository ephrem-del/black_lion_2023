import 'package:flutter/material.dart';

class LoginScreenModel {
  TextEditingController? phoneNumberController;
  TextEditingController? passwordController;
  bool loading = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  Future<bool> login() {
    return Future.delayed(Duration(seconds: 1), () => true);
  }
}
