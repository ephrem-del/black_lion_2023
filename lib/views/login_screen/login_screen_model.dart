import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/students.dart';
import '../../service/logger.dart';

class LoginScreenModel {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool loading = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  Student student = Student(
    firstName: '',
    lastName: '',
    email: '',
    dateSelected: 0,
  );
  Future<bool> isStudentRegistered() async {
    final email = emailController!.text;
    final db = FirebaseFirestore.instance;
    final prefs = await SharedPreferences.getInstance();
    try {
      final snapshot = await db
          .collection('students')
          .doc(email)
          .get();
      if (snapshot.exists) {
        await prefs.setString('email', email);
        await prefs.setBool('isLoggedIn', true);
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      logger.e('error: $e');
      return false;
    } catch (e) {
      logger.e('error: $e');
      return false;
    }
  }

    Future<Student> getStudent(String email) async {
    final db = FirebaseFirestore.instance;
    final result = await db.collection('students').doc(email).get();
    final Student student = Student.fromMap(result);
    return student;
  }

  Future<bool> login() async {
    final email = emailController!.text;
    final password = passwordController!.text;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      logger.e('error: $e');
      return false;
    } catch (e) {
      logger.e('error: e');
      return false;
    }
  }
}
