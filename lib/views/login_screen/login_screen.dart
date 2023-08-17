import 'package:black_lion_2023/service/image_service.dart';
import 'package:black_lion_2023/views/home_screen/home_screen.dart';
import 'package:black_lion_2023/views/login_screen/login_screen_model.dart';
import 'package:black_lion_2023/views/register_screen/register_screen.dart';
import 'package:black_lion_2023/widgets/background_image.dart';
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
    _model.emailController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _model.passwordController!.dispose();
    _model.emailController!.dispose();
    super.dispose();
  }

  login() async {
    if (_model.loginFormKey.currentState!.validate()) {
      setState(() {
        _model.loading = true;
      });
      final result = await _model.login();
      if (result) {
        final isRegistered = await _model.isStudentRegistered();
        setState(() {
          _model.loading = false;
        });
        if (isRegistered) {
          final student = await _model.getStudent(_model.emailController!.text);
          Get.off(() => HomeScreen(
                student: student,
              ));
        } else {
          Get.off(() => RegisterScreen(
                email: _model.emailController!.text,
              ));
        }
      } else {
        setState(() {
          _model.loading = false;
        });
      }
    }
  }

  createAccount() {
    Get.to(() => SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(image: 2),
          SafeArea(
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
                              controller: _model.emailController!,
                              title: 'Email',
                              validate: (t) {
                                if (t == null || t == '') {
                                  return 'Email is required';
                                }
                              },
                            ),
                            CustomTextField(
                              controller: _model.passwordController!,
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
        ],
      ),
    );
  }
}
