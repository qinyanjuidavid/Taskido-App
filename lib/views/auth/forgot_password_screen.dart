import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
// import 'package:taskido/services/auth_services.dart';

class PasswordResetPhoneScreen extends StatefulWidget {
  PasswordResetPhoneScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetPhoneScreen> createState() =>
      _PasswordResetPhoneScreenState();
}

class _PasswordResetPhoneScreenState extends State<PasswordResetPhoneScreen> {
  GlobalKey<FormState> passwordResetPhoneKey = GlobalKey<FormState>();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();

  void _forgotPasswordPhoneFnc() async {
    if (passwordResetPhoneKey.currentState!.validate()) {
      await authService
          .passwordResetPhoneNumber(phoneNumberTextEditingController.text)
          .then((value) {
        if (value != null) {
          Navigator.of(context).pushNamed(
            RouteGenerator.forgotPasswordOtpPage,
          );
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
            "Forgot Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        body: Container(
          child: Form(
            key: passwordResetPhoneKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: phoneNumberTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Phone number",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "phone is required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ),
                MaterialButton(
                  onPressed: _forgotPasswordPhoneFnc,
                  color: Colors.brown,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
