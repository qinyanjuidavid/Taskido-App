import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/validators.dart';
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
        print("++++------------------------+$value");
        if (value != null) {
          Navigator.of(context).pushNamed(RouteGenerator.otpPage);
          print("++++------------------------+$value");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String text1 = "By sign up, you accept to our ";
    final String text2 = "Terms & Conditions";
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Form(
                key: signupFormKey,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 7,
                    right: 7,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Material(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                splashColor: Theme.of(context).splashColor,
                                onTap: () {
                                  Navigator.of(context)
                                      .pop(RouteGenerator.welcomePage);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: SvgPicture.asset(
                          "assets/images/img2.svg",
                        ),
                      ),
                      const Text(
                        "Create an Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "Start you journey with us,",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color.fromARGB(255, 154, 154, 154),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                        validator: (value) =>
                            FormValidators().phoneNumberValidator(
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
                        validator: (value) =>
                            FormValidators().fullNameValidator(
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
                        validator: (value) =>
                            FormValidators().passwordValidator(
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
                        validator: (value) => FormValidators()
                            .passwordConfirmValidator(
                                value!, passwordTextEditingController.text),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: text1.length,
                                child: Text(
                                  text1,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: text2.length,
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    text2,
                                    style: const TextStyle(
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
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.loginPage);
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
                        height: 10,
                      ),
                    ],
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
