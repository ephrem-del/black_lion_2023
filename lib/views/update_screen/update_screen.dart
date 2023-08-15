import 'package:black_lion_2023/views/home_screen/home_screen.dart';
import 'package:black_lion_2023/views/update_screen/update_screen_model.dart';
import 'package:black_lion_2023/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/students.dart';

class UpdateScreen extends StatefulWidget {
  final Student student;
  const UpdateScreen({super.key, required this.student});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late final UpdateScreenModel _model;
  @override
  initState() {
    _model = UpdateScreenModel(student: widget.student);
    super.initState();
  }

  update() async {
    setState(() {
      _model.loading = true;
    });
    final result =
        await _model.update(_model.dates[widget.student.dateSelected - 1]);
    if (result) {
      setState(() {
        _model.loading = false;
      });
      Get.to(() => HomeScreen(student: _model.student));
    } else {
      setState(() {
        _model.loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
              initialSelection: _model.dates[widget.student.dateSelected - 1],
            ),
            CustomButton(
                loading: _model.loading, onPressed: update, title: 'Update')
          ],
        ),
      ),
    );
  }
}
