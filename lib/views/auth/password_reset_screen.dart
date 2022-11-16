import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/validators.dart';
import 'package:taskido/views/auth/auth_base.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

class PasswordResetScreen extends StatefulWidget {
  PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  GlobalKey<FormState> passwordResetFormKey = GlobalKey<FormState>();
  TextEditingController passwordTextEditingController = TextEditingController();

  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  bool _obsecure = true;
  bool _obsecureConfirm = true;
  void _passwordResetFnc() async {
    if (passwordResetFormKey.currentState!.validate()) {
      await authService
          .passwordReset(passwordTextEditingController.text,
              confirmPasswordTextEditingController.text)
          .then((value) {
        if (value != null) {
          Navigator.of(context).popAndPushNamed(RouteGenerator.loginPage);
          passwordTextEditingController.text = "";
          confirmPasswordTextEditingController.text = "";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      title: "Create new password",
      subtitle: "Enter your new password",
      image: "assets/images/forgot_password.svg",
      body: Form(
        key: passwordResetFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Password",
              hintText: "Enter Password",
              obsecure: _obsecure,
              controller: passwordTextEditingController,
              validator: (value) => FormValidators().passwordValidator(value!),
              keyboardType: TextInputType.text,
              onVisibilityChange: () {
                setState(() {
                  _obsecure = !_obsecure;
                });
              },
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithLabel(
              title: "Password Confirm",
              hintText: "Enter Password Confirmation",
              obsecure: _obsecureConfirm,
              controller: confirmPasswordTextEditingController,
              validator: (value) => FormValidators().passwordConfirmValidator(
                  value!, passwordTextEditingController.text),
              keyboardType: TextInputType.text,
              onVisibilityChange: () {
                setState(() {
                  _obsecureConfirm = !_obsecureConfirm;
                });
              },
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthButton(
              onPressed: _passwordResetFnc,
              child: Consumer<AuthService>(
                builder: (context, value, child) {
                  return authService.passwordResetLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
