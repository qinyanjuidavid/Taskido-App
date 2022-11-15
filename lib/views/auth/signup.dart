import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/validators.dart';
import 'package:taskido/views/auth/auth_base.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController fullnameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  bool _obsecure = true;
  bool _obsecureConfirm = true;

  void registerSubmit() async {
    if (signupFormKey.currentState!.validate()) {
      await authService
          .signup(
        phoneNumberTextEditingController.text,
        emailTextEditingController.text,
        fullnameTextEditingController.text,
        passwordTextEditingController.text,
        confirmPasswordTextEditingController.text,
      )
          .then((value) {
        if (value != null) {
          Navigator.of(context).pushNamed(RouteGenerator.otpPage);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      title: "Create an Account",
      subtitle: "Start you journey with us,",
      image: "assets/images/img2.svg",
      body: Form(
        key: signupFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Email",
              controller: emailTextEditingController,
              hintText: "Enter your email",
              prefix: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
              validator: (value) => FormValidators().emailValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Phone",
              controller: phoneNumberTextEditingController,
              hintText: "Enter your phone number",
              prefix: const Icon(Icons.phone, color: Colors.grey),
              validator: (value) => FormValidators().phoneNumberValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Full Name",
              controller: fullnameTextEditingController,
              hintText: "Enter your full name",
              prefix: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              validator: (value) => FormValidators().fullNameValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Password",
              obsecure: _obsecure,
              controller: passwordTextEditingController,
              hintText: "Enter your password",
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              onVisibilityChange: () {
                setState(() {
                  _obsecure = !_obsecure;
                });
              },
              validator: (value) => FormValidators().passwordValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWithLabel(
              title: "Password Confirm",
              controller: confirmPasswordTextEditingController,
              obsecure: _obsecureConfirm,
              hintText: "Enter your password confirmation",
              prefix: const Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              onVisibilityChange: () {
                setState(() {
                  _obsecureConfirm = !_obsecureConfirm;
                });
              },
              validator: (value) => FormValidators().passwordConfirmValidator(
                  value!, passwordTextEditingController.text),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Flexible(
                      child: Text(
                        "By sign up, you accept to our ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Flexible(
                      // flex: text2.length,
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "and ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            AuthButton(
              onPressed: registerSubmit,
              child: Consumer<AuthService>(
                builder: (context, value, child) {
                  if (value.loadingSignup == true) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(0),
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ));
                  }

                  return const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.loginPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color.fromARGB(255, 154, 154, 154),
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color.fromARGB(255, 20, 106, 218),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
