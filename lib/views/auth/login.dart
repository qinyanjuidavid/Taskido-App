import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';

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
  bool obsecure = true;

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
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Form(
                key: loginFormKey,
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
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: SvgPicture.asset(
                          "assets/images/img1.svg",
                        ),
                      ),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        "Sign in to continue,",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color.fromARGB(255, 154, 154, 154),
                        ),
                      ),
                      const SizedBox(height: 15),
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
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "phone is required";
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
                        height: 20,
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
                        obscureText: obsecure,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "password is required";
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
                            onPressed: () {
                              setState(() {
                                obsecure = !obsecure;
                              });
                            },
                            icon: Icon(obsecure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            // color: Color.fromARGB(255, 20, 106, 218),
                          ),
                          hintText: "Your password",
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
                      SizedBox(
                        width: double.infinity,
                        child: RawMaterialButton(
                          onPressed: loginSubmit,
                          // const Color.fromARGB(255, 60, 55, 255),
                          fillColor: const Color.fromARGB(255, 60, 55, 255),
                          //  const Color.fromARGB(255, 20, 106, 218),
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.signUpPage);
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
                            )),
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

    // SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       leading: IconButton(
    //         icon: const Icon(Icons.arrow_back),
    //         onPressed: () {
    //           Navigator.of(context).popAndPushNamed(RouteGenerator.welcomePage);
    //         },
    //       ),
    //       title: const Text(
    //         "Login",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 30,
    //         ),
    //       ),
    //     ),
    //     body: Center(
    //       child: Form(
    //         key: loginFormKey,
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
    //             TextFormField(
    //               obscureText: obsecureText,
    //               controller: passwordTextEditingController,
    //               decoration: const InputDecoration(
    //                 labelText: "Password",
    //               ),
    //               validator: (String? value) {
    //                 if (value == null || value.isEmpty) {
    //                   return "password is required";
    //                 }
    //                 return null;
    //               },
    //             ),
    //             MaterialButton(
    //               color: Colors.brown,
    //               onPressed: loginSubmit,
    //               child: const Text(
    //                 "Login",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width,
    //               height: 7,
    //             ),
    //             Center(
    //               child: GestureDetector(
    //                 onTap: () {
    //                   Navigator.of(context)
    //                       .pushNamed(RouteGenerator.signUpPage);
    //                 },
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: const [
    //                     Text(
    //                       "Don't have an account?",
    //                     ),
    //                     Text(
    //                       "Register",
    //                       style: TextStyle(
    //                         color: Colors.blue,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: MediaQuery.of(context).size.width,
    //               height: 7,
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 Navigator.of(context).pushNamed(
    //                   RouteGenerator.forgotPasswordPage,
    //                 );
    //               },
    //               child: const Text(
    //                 "Forgot Password?",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.blue,
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
