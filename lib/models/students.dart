import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String email;
  final String firstName;
  final String lastName;
  final int dateSelected;
  Student(
      {required this.firstName,
      required this.lastName,
      required this.dateSelected,
      required this.email,
      });
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dateSelected': dateSelected,
      'email': email,
    };
  }

  factory Student.fromMap(DocumentSnapshot snapshot) {
    return Student(
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      dateSelected: snapshot['dateSelected'],
      email: snapshot['email'],
    );
  }
}
