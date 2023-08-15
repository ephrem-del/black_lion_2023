import 'package:black_lion_2023/views/home_screen/home_screen_model.dart';
import 'package:black_lion_2023/views/update_screen/update_screen.dart';
import 'package:black_lion_2023/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/students.dart';

class HomeScreen extends StatefulWidget {
  final Student student;
  const HomeScreen({super.key, required this.student});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {late final HomeScreenModel _model;
  @override
  initState() {
    _model = HomeScreenModel();
    super.initState();
  }

  update() {
    Get.to(() => UpdateScreen(student: widget.student));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text('Hi ${widget.student.firstName} ${widget.student.lastName}'),
          Text(
              'You\'ve selected ${widget.student.dateSelected} for your photoshoot'),
          CustomButton(
              loading: _model.loading, onPressed: update, title: 'Update day'),
        ],)
      ),
    );
  }
}
