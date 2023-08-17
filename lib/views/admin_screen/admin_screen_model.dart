import 'package:black_lion_2023/models/students.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreenModel {
  final db = FirebaseFirestore.instance;
  List<Student> students = [];
  List<Student> day1Students = [];
  List<Student> day2Students = [];
  List<Student> day3Students = [];
  List<Student> day4Students = [];
  fetchStudents() async {
    final snapshot = await db.collection('students').get();
    students = snapshot.docs.map((doc) => Student.fromMap(doc)).toList();
    day1Students =
        students.where((student) => student.dateSelected == 1).toList();
    day2Students =
        students.where((student) => student.dateSelected == 2).toList();
    day3Students =
        students.where((student) => student.dateSelected == 3).toList();
    day4Students =
        students.where((student) => student.dateSelected == 4).toList();
    return;
  }
}
