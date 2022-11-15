import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class OtpInputBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onChanged;
  const OtpInputBox({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        decoration: const InputDecoration(
          hintText: "0",
          hintStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 20, 106, 218),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        style: Theme.of(context).textTheme.headline6,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
