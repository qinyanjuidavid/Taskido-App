import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/validators.dart';
import 'package:taskido/views/auth/auth_base.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

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
    return AuthBase(
      title: "Forgot Password?",
      subtitle: "Please enter the phone number associated with the account,",
      image: "assets/images/forgot_password.svg",
      body: Form(
        key: passwordResetPhoneKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Phone Number",
              hintText: "Enter your phone number",
              validator: (value) =>
                  FormValidators().phoneNumberValidator(value!),
              controller: phoneNumberTextEditingController,
              keyboardType: TextInputType.text,
              prefix: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthButton(
              onPressed: _forgotPasswordPhoneFnc,
              child: Consumer<AuthService>(
                builder: (context, authService, child) {
                  return authService.isSendOtpLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Send OTP",
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
    //         "Forgot Password",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 32,
    //         ),
    //       ),
    //     ),
    //     body: Container(
    //       child: Form(
    //         key: passwordResetPhoneKey,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             TextFormField(
    //               controller: phoneNumberTextEditingController,
    //               decoration: const InputDecoration(
    //                 labelText: "Phone number",
    //               ),
    //               validator: (String? value) {
    //                 if (value == null || value.isEmpty) {
    //                   return "phone is required";
    //                 }
    //                 return null;
    //               },
    //             ),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width,
    //               height: 10,
    //             ),
    //             MaterialButton(
    //               onPressed: _forgotPasswordPhoneFnc,
    //               color: Colors.brown,
    //               child: const Text(
    //                 "Next",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.bold,
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
