import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/views/auth/auth_base.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/otp_input.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  TextEditingController _pin1TextEditingController = TextEditingController();
  TextEditingController _pin2TextEditingController = TextEditingController();
  TextEditingController _pin3TextEditingController = TextEditingController();
  TextEditingController _pin4TextEditingController = TextEditingController();
  TextEditingController _pin5TextEditingController = TextEditingController();
  TextEditingController _pin6TextEditingController = TextEditingController();

  void otpSubmit() async {
    if (otpFormKey.currentState!.validate()) {
      var otp = _pin1TextEditingController.text +
          _pin2TextEditingController.text +
          _pin3TextEditingController.text +
          _pin4TextEditingController.text +
          _pin5TextEditingController.text +
          _pin6TextEditingController.text;

      if (otp.length == 6) {
        await authService.otp(otp).then((value) {
          if (value != null) {
            print(value);
            Navigator.of(context).pushNamed(RouteGenerator.loginPage);
            _pin1TextEditingController.text = "";
            _pin2TextEditingController.text = "";
            _pin3TextEditingController.text = "";
            _pin4TextEditingController.text = "";
            _pin5TextEditingController.text = "";
            _pin6TextEditingController.text = "";
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid OTP"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      title: "Enter OTP",
      subtitle: "Enter the OTP sent to your phone",
      image: "assets/images/otp.svg",
      body: Form(
        key: otpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtpInputBox(
                  controller: _pin1TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin2TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin3TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin4TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin5TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: _pin6TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            AuthButton(
              onPressed: otpSubmit,
              child: Consumer<AuthService>(
                builder: (context, authService, child) {
                  return authService.isOtpLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Verify",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
