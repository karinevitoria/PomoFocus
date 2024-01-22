import 'package:flutter/material.dart';
import 'package:pomo_focus/domain/models/task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'home page',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body: const Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Text(
                'To Do List',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Task(title: 'Task 1', isComplete: false),
              Task(title: 'Task 2', isComplete: false),
              Task(title: 'Task 3', isComplete: true),
              SizedBox(height: 20),
              Text(
                'Done',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
