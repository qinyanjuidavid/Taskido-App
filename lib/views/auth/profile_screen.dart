import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/profile_service.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';
import 'package:taskido/widgets/spinners/spinner.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future logoutFunc(BuildContext context) async {
  await authService.logout().then((value) {
    Navigator.of(context).pushNamed(RouteGenerator.loginPage);
  });
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> profileUpdateKey = GlobalKey<FormState>();
  TextEditingController _fullNameTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _profileUpdateFnc() async {
    if (profileUpdateKey.currentState!.validate()) {
      await profileService
          .updateProfile(
        bio: _bioTextEditingController.text,
        email: _emailTextEditingController.text,
        fullName: _fullNameTextEditingController.text,
        phone: _phoneNumberTextEditingController.text,
        userID: profileService.profileDetails.id,
      )
          .then((value) {
        if (value != null) {
          _refresh();
        }
      });
    }
  }

  Future _refresh() async {
    await Provider.of<ProfileService>(context, listen: false).getProfile();
    _fullNameTextEditingController.text =
        profileService.profileDetails.user!.fullName!.toString();
    _emailTextEditingController.text =
        profileService.profileDetails.user!.email!.toString();
    _phoneNumberTextEditingController.text =
        profileService.profileDetails.user!.phone!.toString();
    _bioTextEditingController.text =
        profileService.profileDetails.bio!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          // .deepOrangeAccent,
          elevation: 20,
          titleSpacing: 20,
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Center(
            child: Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  logoutFunc(context);
                },
                // _logoutFnc,
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<ProfileService>(
            builder: (context, value, child) {
              print(profileService.profileDetails.profilePicture);
              return MaterialSpinner(
                loading: value.profileUpdateLoading,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 14,
                    right: 14,
                  ),
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: Stack(
                            children: [
                              //circle avatar
                              CircleAvatar(
                                radius: 70,
                                backgroundColor:
                                    const Color.fromARGB(255, 60, 55, 255),
                                child: profileService
                                            .profileDetails.profilePicture ==
                                        null
                                    ? const CircleAvatar(
                                        radius: 65,
                                        backgroundImage: AssetImage(
                                            "assets/images/default.png"))
                                    : CircleAvatar(
                                        radius: 65,
                                        backgroundImage: NetworkImage(
                                          profileService
                                              .profileDetails.profilePicture
                                              .toString(),
                                        ),
                                      ),
                              ),
                              //camera icon
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Form(
                        key: profileUpdateKey,
                        child: Column(
                          children: [
                            TextFieldWithLabel(
                              controller: _emailTextEditingController,
                              title: "Email",
                              prefix: const Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWithLabel(
                              controller: _phoneNumberTextEditingController,
                              title: "Phone number",
                              prefix: const Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWithLabel(
                              title: "Full name",
                              controller: _fullNameTextEditingController,
                              prefix: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "About",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 106, 106, 106),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              autofocus: false,
                              controller: _bioTextEditingController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                fillColor:
                                    const Color.fromARGB(255, 245, 170, 51),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 20, 106, 218),
                                      width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: "About yourself",
                                prefixIcon: const Icon(
                                  Icons.info,
                                  color: Colors.grey,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 106, 106, 106),
                              ),
                              maxLines: 5,
                              minLines: 5,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            AuthButton(
                              onPressed: _profileUpdateFnc,
                              child: Consumer<ProfileService>(
                                  builder: (context, value, child) {
                                if (value.profileUpdateLoading == true) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return const Text(
                                  "Update",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
