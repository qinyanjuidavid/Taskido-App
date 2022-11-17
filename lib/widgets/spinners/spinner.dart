import 'package:flutter/material.dart';

class MaterialSpinner extends StatelessWidget {
  final Widget child;
  final bool loading;
  const MaterialSpinner({Key? key, required this.child, required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: SizedBox(
          height: 20.0,
          width: 20.0,
          child: CircularProgressIndicator(
            strokeWidth: 4.0,
          ),
        ),
      );
    } else {
      return Container(
        child: child,
      );
    }
  }
}
