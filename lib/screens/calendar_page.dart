import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pomo_focus/screens/components/bottom_navigation_bar.dart';
import '../domain/models/Task.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Task> tasks = []; // Your list of tasks
  late SharedPreferences sharedPreferences;
  DateTime selectedDate = DateTime.now();
  List<Task> tasksForDate = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadSharedPreferencesAndData();
    filterTasksForSelectedDate();
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

  void filterTasksForSelectedDate() {
    tasksForDate = tasks.where((task) {
      return task.date.year == selectedDate.year &&
          task.date.month == selectedDate.month &&
          task.date.day == selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(),
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime(DateTime.now().year + 5),
            onDateChanged: (date) {
              setState(() {
                selectedDate = date;
              });
              filterTasksForSelectedDate(); // Filter tasks for the selected date
            },
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: tasksForDate.length, // Use tasksForDate.length here
              itemBuilder: (context, index) {
                return Task(
                  title: tasksForDate[index].title,
                  description: tasksForDate[index].description,
                  isUrgent: tasksForDate[index].isUrgent,
                  date: tasksForDate[index].date,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    DateTime date1DateOnly = DateTime(date1.year, date1.month, date1.day);
    DateTime date2DateOnly = DateTime(date2.year, date2.month, date2.day);
    return date1DateOnly == date2DateOnly;
  }
}
