import 'package:black_lion_2023/views/register_screen/register_screen_model.dart';
import 'package:black_lion_2023/widgets/background_container.dart';
import 'package:black_lion_2023/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../home_screen/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String email;
  const RegisterScreen({
    super.key,
    required this.email,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterScreenModel _model;
  @override
  void initState() {
    _model = RegisterScreenModel(email: widget.email);
    _model.firstNameController = TextEditingController();
    _model.lastNameController = TextEditingController();
    super.initState();
  }

  register() async {
    if (_model.registrationFormKey.currentState!.validate()) {
      final result = await _model.register();
      if (result) {
        setState(() {
          _model.loading = false;
          _model.errorText = '';
        });
        print('registered');
        Get.off(() => HomeScreen(student: _model.student));
      } else {
        setState(() {
          _model.loading = false;
        });
        print('failed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _model.registrationFormKey,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Register Page',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _model.errorText != ''
                      ? Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            _model.errorText,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  BackgroundContainer(
                    child: Column(
                      children: [
                        CustomTextField(
                          title: 'First Name',
                          validate: (t) {
                            if (t == null || t == '') {
                              return 'First name is required';
                            }
                            return null;
                          },
                          controller: _model.firstNameController!,
                        ),
                        CustomTextField(
                          title: 'Last Name',
                          validate: (t) {
                            if (t == null || t == '') {
                              return 'Last name is required';
                            }
                            return null;
                          },
                          controller: _model.lastNameController!,
                        ),
                        SizedBox(
                          width: Get.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              DropdownMenu(
                                dropdownMenuEntries: _model.dates
                                    .map((day) => DropdownMenuEntry(
                                          label: day,
                                          value: day,
                                        ))
                                    .toList(),
                                onSelected: (value) {
                                  setState(() {
                                    _model.selectedDate = value!;
                                  });
                                },
                                initialSelection: _model.dates.first,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: CustomButton(
                              loading: _model.loading,
                              onPressed: register,
                              title: 'Register'),
                        )
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
