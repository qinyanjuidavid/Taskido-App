import 'dart:ffi';

import "package:flutter/material.dart";

class ForgotPasswordOtp extends StatefulWidget {
  ForgotPasswordOtp({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtp> createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
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
