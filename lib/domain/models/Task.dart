import 'package:flutter/material.dart';
import '../../screens/edit_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Task extends StatefulWidget {
  String title;
  String description;
  bool isUrgent;
  DateTime date;

  Task(
      {super.key,
      required this.title,
      required this.description,
      this.isUrgent = false,
      required this.date});

  Task.fromMap(Map map, {super.key})
      : title = map['title'],
        description = map['description'],
        isUrgent = map['isUrgent'],
        date = DateTime.parse(map['date']);

  Map toMap() {
    return {
      'title': title,
      'description': description,
      'isUrgent': isUrgent,
      'date': date.toIso8601String()
    };
  }

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isComplete = false;
  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    loadData();
  }

  void _editTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTask(
          title: widget.title,
          description: widget.description,
          isUrgent: widget.isUrgent,
          date: widget.date,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        widget.title = result['title'];
        widget.description = result['description'];
        widget.isUrgent = result['isUrgent'];
        widget.date = result['date'];
        saveData();
      });
    }
  }

  initSharedPreferences() async {
    sharedPreferences =
        (await SharedPreferences.getInstance()) as Future<SharedPreferences>;
  }

  void saveData() async {
    final prefs = await sharedPreferences;
    String key = 'task_${widget.date.millisecondsSinceEpoch}';
    Map<String, dynamic> taskMap = {
      'title': widget.title,
      'description': widget.description,
      'isUrgent': widget.isUrgent,
      'date': widget.date.toIso8601String(),
    };
    String jsonString = json.encode(taskMap);
    prefs.setString(key, jsonString);
  }

  void loadData() async {
    final prefs = await sharedPreferences;
    String key = 'task_${widget.date.millisecondsSinceEpoch}';
    String? jsonString = prefs.getString(key);

    if (jsonString != null) {
      Map<String, dynamic> taskMap = json.decode(jsonString);
      setState(() {
        widget.title = taskMap['title'];
        widget.description = taskMap['description'];
        widget.isUrgent = taskMap['isUrgent'];
        widget.date = DateTime.parse(taskMap['date']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _editTask();
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
