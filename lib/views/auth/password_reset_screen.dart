import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Password Reset",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        body: Container(
          child: Form(
            key: passwordResetFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWithLabel(
                  title: "Password",
                  controller: passwordTextEditingController,
                  obsecure: _obsecure,
                  onVisibilityChange: () {
                    setState(() {
                      _obsecure = !_obsecure;
                    });
                  },
                  prefix: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "password is required";
                    }
                    if (value.length < 6) {
                      return "password must be at least 6 characters";
                    }

                    return null;
                  },
                ),
                TextFieldWithLabel(
                  title: "Password confirm",
                  controller: confirmPasswordTextEditingController,
                  obsecure: _obsecureConfirm,
                  prefix: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  onVisibilityChange: () {
                    setState(() {
                      _obsecureConfirm = !_obsecureConfirm;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "password confirm is required";
                    }

                    if (value != passwordTextEditingController.text) {
                      return "password confirm must be equal to password";
                    }

                    return null;
                  },
                ),
                AuthButton(
                  onPressed: _passwordResetFnc,
                  child: Consumer<AuthService>(
                    builder: ((context, value, child) {
                      if (value.passwordResetLoading == true) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          ),
                        );
                      }
                      return const Text(
                        "Reset Password",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
