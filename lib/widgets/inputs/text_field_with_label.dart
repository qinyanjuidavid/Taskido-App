import 'package:flutter/material.dart';

class TextFieldWithLabel extends StatelessWidget {
  final String title;
  final bool obsecure;
  final Widget? suffix;
  final Widget? prefix;
  final String? hintText;
  final Function? onVisibilityChange;
  final String? Function(String?)? validator;
  final Color? color;
  final TextEditingController controller;
  final Function? onChange;
  final keyboardType;

  const TextFieldWithLabel({
    Key? key,
    required this.title,
    required this.controller,
    this.obsecure = false,
    this.suffix,
    this.prefix,
    this.hintText,
    this.onVisibilityChange,
    this.validator,
    this.color,
    this.onChange,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 106, 106, 106),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            autofocus: false,
            controller: controller,
            obscureText: obsecure,
            keyboardType: keyboardType,
            validator: validator,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: const Color.fromARGB(255, 245, 170, 51),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 20, 106, 218), width: 2.0),
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: hintText,
              prefixIcon: prefix,
              suffixIcon: suffix ??
                  (onVisibilityChange != null
                      ? IconButton(
                          onPressed: () {
                            onVisibilityChange!();
                          },
                          icon: Icon(
                            obsecure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                        )
                      : null),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 106, 106, 106),
            ),
          ),
        ],
      ),
    );
  }
}
