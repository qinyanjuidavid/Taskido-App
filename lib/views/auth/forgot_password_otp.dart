import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/views/auth/auth_base.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/otp_input.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  ForgotPasswordOtpScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  TextEditingController _pin1TextEditingController = TextEditingController();
  TextEditingController _pin2TextEditingController = TextEditingController();
  TextEditingController _pin3TextEditingController = TextEditingController();
  TextEditingController _pin4TextEditingController = TextEditingController();
  TextEditingController _pin5TextEditingController = TextEditingController();
  TextEditingController _pin6TextEditingController = TextEditingController();

  void _passwordTokenCheckFnc() async {
    if (otpFormKey.currentState!.validate()) {
      var otp = _pin1TextEditingController.text +
          _pin2TextEditingController.text +
          _pin3TextEditingController.text +
          _pin4TextEditingController.text +
          _pin5TextEditingController.text +
          _pin6TextEditingController.text;
      if (otp.length == 6) {
        await authService.passwordResetTokenCheck(otp).then((value) {
          if (value != null) {
            Navigator.of(context).pushNamed(RouteGenerator.passwordResetPage);
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
      title: "Enter your verification code",
      subtitle:
          "We have sent you a 6 digit code to your phone. You can check your inbox.",
      image: "assets/images/forgot_password.svg",
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
            const SizedBox(
              height: 30,
            ),
            AuthButton(
              onPressed: _passwordTokenCheckFnc,
              child: Consumer<AuthService>(
                builder: (context, authService, child) {
                  return authService.isPasswordOTPLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Verify OTP",
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

    // SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(
    //         "Password Reset OTP",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //     body: Container(
    //       child: Form(
    //         key: otpFormKey,
    //         child: Column(
    //           children: [
    //             TextFormField(
    //               controller: otpTextEditingController,
    //               decoration: const InputDecoration(
    //                 labelText: "OTP",
    //               ),
    //               validator: (String? value) {
    //                 if (value == null || value.isEmpty) {
    //                   return "otp is required";
    //                 }
    //                 return null;
    //               },
    //             ),
    //             MaterialButton(
    //               color: Colors.brown,
    //               onPressed: _passwordTokenCheckFnc,
    //               child: const Text(
    //                 "Next",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
