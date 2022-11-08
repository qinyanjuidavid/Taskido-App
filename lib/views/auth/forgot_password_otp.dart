import 'dart:ffi';

import "package:flutter/material.dart";

class ForgotPasswordOtpScreen extends StatefulWidget {
  ForgotPasswordOtpScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Password Reset OTP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(),
      ),
    );
  }
}
