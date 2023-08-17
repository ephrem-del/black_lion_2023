import 'package:black_lion_2023/views/home_screen/home_screen.dart';
import 'package:black_lion_2023/views/update_screen/update_screen_model.dart';
import 'package:black_lion_2023/widgets/background_container.dart';
import 'package:black_lion_2023/widgets/background_image.dart';
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
    final result = await _model.update(_model.selectedDate);
    if (result) {
      setState(() {
        _model.loading = false;
      });
      Get.to(() => HomeScreen(student: _model.student));
    } else {
      setState(() {
        _model.loading = false;
      });
      showErrorDialog();
    }
  }

  showErrorDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('error'),
            content: Text(_model.errorText),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(image: 1),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: BackgroundContainer(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        DropdownMenu(
                          dropdownMenuEntries: _model.dates
                              .map((day) => DropdownMenuEntry(
                                    label: _model.returnDateNames(day),
                                    value: day,
                                  ))
                              .toList(),
                          onSelected: (value) {
                            setState(() {
                              _model.selectedDate = value!;
                            });
                          },
                          initialSelection:
                              _model.dates[widget.student.dateSelected - 1],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            loading: _model.loading,
                            onPressed: update,
                            title: 'Update')
                      ],
                    ),
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
