import 'package:black_lion_2023/views/home_screen/home_screen.dart';
import 'package:black_lion_2023/views/login_screen/login_screen.dart';
import 'package:black_lion_2023/views/signup_screen/signup_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/image_service.dart';
import '../../widgets/background_container.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SignupScreenModel _model;
  @override
  void initState() {
    _model = SignupScreenModel();
    _model.passwordController = TextEditingController();
    _model.phoneNumberController = TextEditingController();
    super.initState();
  }

  login() {
    Get.to(() => LoginScreen());
  }

  createAccount() async {
    if (_model.signupFormKey.currentState!.validate()) {
      setState(() {
        _model.loading = true;
      });
      final result = await _model.createAccount();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _model.signupFormKey,
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
                          controller: _model.phoneNumberController!,
                          title: 'Phone Number',
                          number: true,
                          validate: (t) {
                            if (t == null || t == '') {
                              return 'Phone number is required';
                            } else if (t.length != 9) {
                              return 'phone number must be in 9******** format';
                            }
                            return null;
                          },
                        ),
                        // CustomTextField(
                        //   title: 'Password',
                        //   validate: (t) {
                        //     if (t == null || t == '') {
                        //       return 'Password is required';
                        //     }
                        //   },
                        // ),
                        CustomButton(
                          title: 'Create Account',
                          onPressed: createAccount,
                          loading: _model.loading,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text('Already have an account?'),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          loading: _model.loading,
                          onPressed: login,
                          title: 'Login',
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
