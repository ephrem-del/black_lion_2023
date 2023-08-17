import 'package:black_lion_2023/views/home_screen/home_screen_model.dart';
import 'package:black_lion_2023/views/update_screen/update_screen.dart';
import 'package:black_lion_2023/widgets/background_container.dart';
import 'package:black_lion_2023/widgets/background_image.dart';
import 'package:black_lion_2023/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/students.dart';
import '../admin_screen/admin_screen.dart';

class HomeScreen extends StatefulWidget {
  final Student student;
  const HomeScreen({super.key, required this.student});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenModel _model;
  final TextEditingController passwordController = TextEditingController();
  @override
  initState() {
    _model = HomeScreenModel();
    super.initState();
  }

  update() {
    Get.to(() => UpdateScreen(student: widget.student));
  }

  adminLogin(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: SizedBox(
            height: 100,
            child: BackgroundContainer(
                child: Column(
              children: [
                Text('Password'),
                TextFormField(
                  controller: passwordController,
                ),
                ElevatedButton(
                  onPressed: adminScreen,
                  child: Text('Login'),
                ),
              ],
            )),
          ));
        });
  }

  adminScreen() {
    // if (passwordController.text == '1234') {
      Get.to(() => AdminScreen());
    // } else {
    //   Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BackgroundContainer(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hi ${widget.student.firstName} ${widget.student.lastName}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You\'ve selected ${widget.student.dateSelected} for your photoshoot',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            loading: _model.loading,
                            onPressed: update,
                            title: 'Update day'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  loading: false,
                  onPressed: adminScreen,
                  title: 'Admin Login',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
