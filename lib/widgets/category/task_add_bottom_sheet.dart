import "package:flutter/material.dart";

class TaskBottomSheet extends StatelessWidget {
  final Widget taskForm;
  const TaskBottomSheet({Key? key, required this.taskForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    return _makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.3,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                taskForm,
              ],
            ),
          );
        },
      ),
    );
  }
}
