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
  TextEditingController pin1TextEditingController = TextEditingController();
  TextEditingController pin2TextEditingController = TextEditingController();
  TextEditingController pin3TextEditingController = TextEditingController();
  TextEditingController pin4TextEditingController = TextEditingController();
  TextEditingController pin5TextEditingController = TextEditingController();
  TextEditingController pin6TextEditingController = TextEditingController();

  void otpSubmit() async {
    if (otpFormKey.currentState!.validate()) {
      var otp = pin1TextEditingController.text +
          pin2TextEditingController.text +
          pin3TextEditingController.text +
          pin4TextEditingController.text +
          pin5TextEditingController.text +
          pin6TextEditingController.text;

      if (otp.length == 6) {
        await authService.otp(otp).then((value) {
          if (value != null) {
            print(value);
            Navigator.of(context).pushNamed(RouteGenerator.loginPage);
          }
        });
      } else {
        //display snackbar
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
                  controller: pin1TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: pin2TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: pin3TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: pin4TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: pin5TextEditingController,
                  onChanged: (value) {
                    if (value!.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
                const SizedBox(width: 2),
                OtpInputBox(
                  controller: pin6TextEditingController,
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

    /////////////////////////////////////////  //

    // SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       leading: IconButton(
    //         onPressed: () {
    //           Navigator.of(context).popAndPushNamed(RouteGenerator.signUpPage);
    //         },
    //         icon: const Icon(
    //           Icons.arrow_back,
    //         ),
    //       ),
    //       title: const Text(
    //         "OTP",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 28,
    //         ),
    //       ),
    //     ),
    //     body: Form(
    //       key: otpFormKey,
    //       child: Column(
    //         children: [
    //           TextFormField(
    //             controller: otpTextEditingController,
    //             decoration: const InputDecoration(
    //               labelText: "OTP",
    //               hintText: "Enter OTP",
    //             ),
    //             validator: (String? value) {
    //               if (value == null || value.isEmpty) {
    //                 return "otp is required";
    //               }
    //               return null;
    //             },
    //           ),
    //           MaterialButton(
    //             onPressed: otpSubmit,
    //             color: Colors.brown,
    //             child: const Text(
    //               "Verify",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // /////////////////////////////////
  }
}
