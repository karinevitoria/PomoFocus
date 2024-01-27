import 'package:flutter/material.dart';
import '../../screens/edit_task.dart';

class Task extends StatefulWidget {
  String title;
  String description;
  bool isUrgent;

  Task(
      {super.key,
      required this.title,
      required this.description,
      this.isUrgent = false});

  Task.fromMap(Map map, {super.key})
      : title = map['title'],
        description = map['description'],
        isUrgent = map['isUrgent'];

  Map toMap() {
    return {'title': title, 'description': description, 'isUrgent': isUrgent};
  }

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTask(
              title: widget.title,
              description: widget.description,
              isUrgent: widget.isUrgent,
            ),
          ),
        );

        if (result != null) {
          setState(() {
            widget.title = result['title'];
            widget.description = result['description'];
            widget.isUrgent = result['isUrgent'];
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: 1,
          ),
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
                color: Color.fromARGB(255, 255, 1, 1),
              ),
            if (isComplete)
              const Icon(
                Icons.done,
                color: Color.fromARGB(255, 52, 250, 3),
              ),
          ],
        ),
      ),
    );
  }
}
