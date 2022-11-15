import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthBase extends StatelessWidget {
  final Widget body;
  final String? title;
  final String? subtitle;
  final String? image;
  const AuthBase({
    Key? key,
    required this.body,
    this.title,
    this.subtitle,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: 14,
            right: 14,
          ),
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Stack(
                children: [
                  Material(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: SvgPicture.asset(
                  image!,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              body,
            ],
          ),
        ),
      ),
    );
  }
}
