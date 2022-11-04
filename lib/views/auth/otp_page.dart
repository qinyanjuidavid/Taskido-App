import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  TextEditingController otpTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed(RouteGenerator.signUpPage);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text(
            "OTP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        body: Form(
          key: otpFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: otpTextEditingController,
                decoration: const InputDecoration(
                  labelText: "OTP",
                  hintText: "Enter OTP",
                ),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.brown,
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
