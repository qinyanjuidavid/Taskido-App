import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/services/profile_service.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
    _fullNameTextEditingController.text =
        profileService.profileDetails.user!.fullName!.toString();
    _emailTextEditingController.text =
        profileService.profileDetails.user!.email!.toString();
    _phoneNumberTextEditingController.text =
        profileService.profileDetails.user!.phone!.toString();
    _bioTextEditingController.text =
        profileService.profileDetails.bio!.toString();
  }

  Future _refresh() async {
    await Future.delayed(Duration(seconds: 1));
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
              "Edit profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
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
                          backgroundColor: Colors.black87,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage(
                              profileService.profileDetails.profilePicture
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
                              color: Colors.black87,
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
                      TextFieldWithLabel(
                        title: "About",
                        controller: _bioTextEditingController,
                        prefix: const Icon(
                          Icons.info,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AuthButton(
                        onPressed: () {},
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
                    ],
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
