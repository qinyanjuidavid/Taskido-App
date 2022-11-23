import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final Function onTap;
  final bool value;
  final Function(bool?) onChanged;
  final String task;
  final String dueDate;
  final String dueDateFormatted;
  final String dueTime;
  const TaskContainer(
      {Key? key,
      required this.onTap,
      required this.value,
      required this.onChanged,
      required this.task,
      required this.dueDate,
      required this.dueDateFormatted,
      required this.dueTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
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
            Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: onChanged,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        task,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: dueDate == null
                          ? const Text("")
                          : Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  dueDate == null ? "" : dueDateFormatted,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  dueDate == null ? "" : dueTime,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
