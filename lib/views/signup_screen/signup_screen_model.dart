import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreenModel {
  TextEditingController? phoneNumberController;
  TextEditingController? passwordController;
  bool loading = false;
  int? resendTokenVariable;
  String errorText = '';
  int? otp;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  ///response codes
  /// 1 login directly
  /// 2 prompt user to enter otp
  /// 3 verification failed
  Future<bool> createAccount() async {
    final String phoneNumber = phoneNumberController!.text;

    await auth.verifyPhoneNumber(
      phoneNumber: '+251$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          errorText = 'invalid phone number';
          print('The provided phone number is not valid.');
        } else {
          print('other error');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        resendTokenVariable = resendToken;
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = otp.toString();

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return true;
  }

  Future<bool> resendCode() async {
    return Future.delayed(Duration(seconds: 1), () {
      return true;
    });
  }
}
