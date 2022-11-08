import 'package:flutter/material.dart';

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

  void _forgotPasswordPhone() {}
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
                  onPressed: _forgotPasswordPhone,
                  child: const Text(
                    "Next",
                    style: TextStyle(
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
