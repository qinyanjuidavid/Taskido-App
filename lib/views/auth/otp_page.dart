import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/views/auth/auth_base.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  TextEditingController otpTextEditingController = TextEditingController();

  void otpSubmit() async {
    if (otpFormKey.currentState!.validate()) {
      await authService.otp(otpTextEditingController.text).then((value) {
        if (value != null) {
          print(value);
          Navigator.of(context).pushNamed(RouteGenerator.loginPage);
        }
      });
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
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    // style: Theme.of(context).textTheme.headLine6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    // style: Theme.of(context).textTheme.headLine6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    // style: Theme.of(context).textTheme.headLine6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    // style: Theme.of(context).textTheme.headLine6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                SizedBox(
                  height: 68,
                  width: 64,
                  child: TextField(
                    // style: Theme.of(context).textTheme.headLine6,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
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
