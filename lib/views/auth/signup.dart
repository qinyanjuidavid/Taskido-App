import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obsecure = true;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController fullnameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();

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
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 106, 106, 106),
                            fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: false,
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "email address is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fillColor: const Color.fromARGB(255, 245, 170, 51),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 20, 106, 218),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Your email",
                          prefixIcon: const Icon(
                            Icons.mail,
                            // color: Color.fromARGB(255, 20, 106, 218),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Phone",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 106, 106, 106),
                            fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: false,
                        controller: phoneNumberTextEditingController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "phone number is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fillColor: const Color.fromARGB(255, 245, 170, 51),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 20, 106, 218),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Your phone number",
                          prefixIcon: const Icon(
                            Icons.phone,
                            // color: Color.fromARGB(255, 20, 106, 218),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Full Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 106, 106, 106),
                            fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: false,
                        controller: fullnameTextEditingController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "full name is required";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fillColor: const Color.fromARGB(255, 245, 170, 51),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 20, 106, 218),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Your full name",
                          prefixIcon: const Icon(
                            Icons.person,
                            // color: Color.fromARGB(255, 20, 106, 218),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 106, 106, 106),
                            fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: false,
                        controller: passwordTextEditingController,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "password is required";
                          }
                          if (value.length < 6) {
                            return "password must be at least 6 characters";
                          }

                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fillColor: const Color.fromARGB(255, 245, 170, 51),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 20, 106, 218),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            // color: Color.fromARGB(255, 20, 106, 218),
                          ),
                          hintText: "Your password",
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Password Confirmation",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 106, 106, 106),
                            fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        autofocus: false,
                        controller: confirmPasswordTextEditingController,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "password confirmation is required";
                          }

                          if (value != passwordTextEditingController.text) {
                            return "password confirm must be equal to password";
                          }

                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fillColor: const Color.fromARGB(255, 245, 170, 51),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 20, 106, 218),
                                width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            // color: Color.fromARGB(255, 20, 106, 218),
                          ),
                          hintText: "Your password Confirmation",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: const Text(
                                  "By sign up, you accept to our ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "Terms & Conditions",
                                    style: TextStyle(
                                      fontSize: 15,
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
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .pushNamed(RouteGenerator.forgotPasswordPage);
                      //   },
                      //   child: const Text(
                      //     "",
                      //     style: TextStyle(
                      //       fontSize: 12,
                      //       color: Color.fromARGB(255, 20, 106, 218),
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: RawMaterialButton(
                          onPressed: registerSubmit,
                          fillColor: const Color.fromARGB(255, 20, 106, 218),
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
                              "Joined us before? ",
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
