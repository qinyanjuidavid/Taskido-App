import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/validators.dart';
import 'package:taskido/views/auth/auth_base.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  //obsecure for password
  bool _obsecure = true;

  @override
  void initState() {
    super.initState();
  }

  void loginSubmit() async {
    if (loginFormKey.currentState!.validate()) {
      await authService
          .login(
        phoneNumberTextEditingController.text,
        passwordTextEditingController.text,
      )
          .then(
        (value) {
          if (value != null) {
            Navigator.of(context).pushNamed(RouteGenerator.homePage);
            phoneNumberTextEditingController.text = "";
            passwordTextEditingController.text = "";
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBase(
      title: "Welcome Back",
      subtitle: "Sign in to continue,",
      image: "assets/images/img1.svg",
      body: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWithLabel(
              title: "Phone",
              controller: phoneNumberTextEditingController,
              hintText: "Enter your phone number",
              prefix: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              keyboardType: TextInputType.text,
              // FormValidator for phone number
              validator: (value) => FormValidators().phoneNumberValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
              hintText: "Enter your password",
              validator: (value) => FormValidators().passwordValidator(
                value!,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteGenerator.forgotPasswordPage);
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 20, 106, 218),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AuthButton(
              onPressed: loginSubmit,
              child: Consumer<AuthService>(
                builder: ((context, value, child) {
                  if (value.loadingLogin == true) {
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
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.signUpPage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color.fromARGB(255, 154, 154, 154),
                    ),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color.fromARGB(255, 20, 106, 218),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: Divider()),
                Text(" OR "),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: Color.fromARGB(255, 239, 239, 239),
                focusColor: Color.fromARGB(255, 20, 106, 218),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/google_signin.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        color: Color.fromARGB(255, 72, 72, 72),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
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
