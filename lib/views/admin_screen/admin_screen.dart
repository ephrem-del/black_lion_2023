import 'package:black_lion_2023/service/image_service.dart';
import 'package:flutter/material.dart';

import '../../models/students.dart';
import 'admin_screen_model.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  AdminScreenModel? _model;
  @override
  void initState() {
    _model = AdminScreenModel();
    getStudents();
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  getStudents() async {
    await _model!.fetchStudents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Screen'),
        centerTitle: true,
        backgroundColor: Colors.black54,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Day 1'),
            ),
            Text('Day 2'),
            Text('Day 3'),
            Text('Day 4'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(opacity: 0.5,
            child: Image.asset(ImageService.logo),
            ),
          ),
          SafeArea(
            child: TabBarView(
              controller: tabController,
              children: [
                StudentList(students: _model!.day1Students),
                StudentList(students: _model!.day2Students),
                StudentList(students: _model!.day3Students),
                StudentList(students: _model!.day4Students),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  final List<Student> students;
  const StudentList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: students
          .map(
            (student) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Text(
                    student.firstName.capitalize(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(student.lastName.capitalize(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}