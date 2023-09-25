import 'package:black_lion_2023/models/students.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/logger.dart';
import '../../utils/days.dart';

class RegisterScreenModel {
  final String email;
  RegisterScreenModel({required this.email});
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  String selectedDate = 'Day 1';
  bool loading = false;
  String errorText = '';
  Student student = Student(
    dateSelected: 0,
    firstName: '',
    lastName: '',
    email: '',
  );
  final db = FirebaseFirestore.instance;
  List<String> dates = [
    'Day 1',
    'Day 2',
    'Day 3',
    'Day 4',
  ];

  List<String> dateNames = [
    XDays.day1,
    XDays.day2,
    XDays.day3,
    XDays.day4,
  ];

  returnDateNames(day) {
    if (day == 'Day 1') {
      return dateNames[0];
    } else if (day == 'Day 2') {
      return dateNames[1];
    } else if (day == 'Day 3') {
      return dateNames[2];
    } else
      return dateNames[3];
  }

  int selectedDateToInt(String date) {
    if (date == 'Day 1') {
      return 1;
    } else if (date == 'Day 2') {
      return 2;
    } else if (date == 'Day 3') {
      return 3;
    } else {
      return 4;
    }
  }

  String documentName(String date) {
    if (date == 'Day 1') {
      return 'day1';
    } else if (date == 'Day 2') {
      return 'day2';
    } else if (date == 'Day 3') {
      return 'day3';
    } else {
      return 'day4';
    }
  }

  Future<bool> register() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = firstNameController!.text;
    final lastName = lastNameController!.text;
    student = Student(
      firstName: firstName,
      lastName: lastName,
      dateSelected: selectedDateToInt(selectedDate),
      email: email,
    );

    final updatePossible = await updateDates();
    if (updatePossible) {
      try {
        await db.collection('students').doc(email).set(student.toMap());
        await prefs.setString('email', email);
        await prefs.setBool('isLoggedIn', true);
        // await db.collection('students').add(student.toMap());
        return true;
      } on FirebaseException catch (e) {
        logger.e('error: $e');
        return false;
      } catch (e) {
        logger.e('error: $e');
        return false;
      }
    } else {
      errorText = 'Date already full try a different date';
      return false;
    }
  }

  Future<bool> updateDates() async {
    final snapshot =
        await db.collection('dates').doc(documentName(selectedDate)).get();
    final registered = snapshot['registered'];
    logger.i('registered on $selectedDate: $registered');
    if (registered < 60) {
      await db
          .collection('dates')
          .doc(documentName(selectedDate))
          .update({'registered': registered + 1});
      return true;
    } else {
      return false;
    }
  }
}
