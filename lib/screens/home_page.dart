import 'dart:convert';
import 'package:flutter/material.dart';
import '../domain/models/Task.dart';
import 'create_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomo_focus/screens/components/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  late SharedPreferences sharedPreferences;

  void _createTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTask(),
      ),
    );

    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
        saveData();
      });
    }
  }

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    List<String>? listString = sharedPreferences.getStringList('tasks');
    if (listString != null) {
      tasks =
          listString.map((item) => Task.fromMap(json.decode(item))).toList();
      setState(() {});
    }
  }

  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveData() {
    List<String> stringList =
        tasks.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('tasks', stringList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'To do list',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Task(
                    title: tasks[index].title,
                    description: tasks[index].description,
                    isUrgent: tasks[index].isUrgent,
                    date: tasks[index].date,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
