import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String title;
  final String description;
  final bool isUrgent;

  Task({required this.title, required this.description, this.isUrgent = false});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          if (!isComplete)
            Checkbox(
              value: isComplete,
              onChanged: (bool? value) {
                setState(() {
                  isComplete = value ?? false;
                });
              },
            ),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          const Spacer(),
          if (widget.isUrgent && !isComplete)
            const Icon(
              Icons.warning,
              color: Colors.yellow,
            ),
          if (isComplete)
            const Icon(
              Icons.done,
              color: Color.fromARGB(255, 52, 250, 3),
            ),
        ],
      ),
    );
  }
}
