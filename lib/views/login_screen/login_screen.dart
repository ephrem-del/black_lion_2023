import 'package:black_lion_2023/service/image_service.dart';
import 'package:black_lion_2023/views/home_screen/home_screen.dart';
import 'package:black_lion_2023/views/login_screen/login_screen_model.dart';
import 'package:black_lion_2023/widgets/custom_button.dart';
import 'package:black_lion_2023/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/background_container.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginScreenModel _model;
  @override
  initState() {
    _model = LoginScreenModel();
    _model.passwordController = TextEditingController();
    _model.phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _model.passwordController!.dispose();
    _model.phoneNumberController!.dispose();
    super.dispose();
  }

  login() async {
    setState(() {
      _model.loading = true;
    });
    final result = await _model.login();
    if (result) {
      setState(() {
        _model.loading = false;
      });
      Get.off(() => HomeScreen());
    } else {
      setState(() {
        _model.loading = false;
      });
    }
  }

  createAccount() {
    Get.to(() => SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _model.loginFormKey,
            child: SizedBox(
              width: double.infinity,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageService.logo,
                    height: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BackgroundContainer(
                    child: Column(
                      children: [
                        CustomTextField(
                          title: 'Phone Number',
                          validate: (t) {
                            if (t == null || t == '') {
                              return 'Phone number is required';
                            }
                          },
                        ),
                        CustomTextField(
                          title: 'Password',
                          validate: (t) {
                            if (t == null || t == '') {
                              return 'Password is required';
                            }
                          },
                        ),
                        CustomButton(
                          title: 'Login',
                          onPressed: login,
                          loading: _model.loading,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text('Haven\'t created your account yet?'),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          loading: _model.loading,
                          onPressed: createAccount,
                          title: 'Create Account',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
