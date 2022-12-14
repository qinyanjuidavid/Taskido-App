import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';

class CompleteAndUncompleteContainerWidget extends StatelessWidget {
  final String title;
  final String numberOfTasks;
  final Color color;
  //pass navigation route
  final String route;

  const CompleteAndUncompleteContainerWidget({
    Key? key,
    required this.title,
    required this.numberOfTasks,
    required this.color,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          padding: const EdgeInsets.only(
            top: 18,
            left: 15,
          ),
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.darken,
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    numberOfTasks,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Tasks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
