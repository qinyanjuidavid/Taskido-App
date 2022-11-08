import "package:flutter/material.dart";
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  ForgotPasswordOtpScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  TextEditingController otpTextEditingController = TextEditingController();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  void _passwordTokenCheckFnc() async {
    if (otpFormKey.currentState!.validate()) {
      await authService
          .passwordResetTokenCheck(otpTextEditingController.text)
          .then((value) {
        if (value != null) {
          Navigator.of(context).pushNamed(RouteGenerator.passwordResetPage);
          otpTextEditingController.text = "";
        }
      });
    }
  }

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
        body: Container(
          child: Form(
            key: otpFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: otpTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "OTP",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "otp is required";
                    }
                    return null;
                  },
                ),
                MaterialButton(
                  color: Colors.brown,
                  onPressed: _passwordTokenCheckFnc,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
