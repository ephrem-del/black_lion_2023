import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/students.dart';
import '../../service/logger.dart';

class UpdateScreenModel {
  Student student;
  UpdateScreenModel({required this.student});
  bool loading = false;
  final db = FirebaseFirestore.instance;
  String errorText = '';
  String selectedDate = '';

  List<String> dates = [
    'Day 1',
    'Day 2',
    'Day 3',
    'Day 4',
  ];

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

  Future<bool> _updateDates() async {
    // final selectedDate = dates[student.dateSelected];
    final snapshot =
        await db.collection('dates').doc(documentName(selectedDate)).get();
    final registered = snapshot['registered'];
    logger.i('registered on $selectedDate: $registered');
    if (registered < 40) {
      await db
          .collection('dates')
          .doc(documentName(selectedDate))
          .update({'registered': registered + 1});
      return true;
    } else {
      return false;
    }
  }

  Future<bool> update(String sselectedDate) async {
    selectedDate = sselectedDate;
    final day1DocName = documentName(dates[student.dateSelected-1]);
    final day2DocName = documentName(selectedDate);
    final isUpdatePossible = await _updateDates();
    if (isUpdatePossible) {
      try {
        final registered1Snapshot =
            await db.collection('dates').doc(day1DocName).get();
        final registered2Snapshot =
            await db.collection('dates').doc(day2DocName).get();
        final registered1 = registered1Snapshot['registered'];
        final registered2 = registered2Snapshot['registered'];
        final dt1 = registered1 - 1;
        final dt2 = registered2 + 1;
        await db.collection('dates').doc(day1DocName).set({'registered': dt1});
        await db.collection('dates').doc(day2DocName).set({'registered': dt2});

        student = Student(
            firstName: student.firstName,
            lastName: student.lastName,
            dateSelected: selectedDateToInt(selectedDate),
            email: student.email);
        await db.collection('students').doc(student.email).set(student.toMap());
        return true;
      } on FirebaseException catch (e) {
        logger.e('error: $e');
        errorText = 'Unknown error please try again later';
        return false;
      } catch (e) {
        logger.e('error: $e');
        errorText = 'Unknown error please try again later';
        return false;
      }
    } else {
      errorText = 'Please select a different date, date is fully booked';
      return false;
    }
  }
}