import 'package:flutter/material.dart';
import '../domain/models/Task.dart';

class CreateTask extends StatefulWidget {
  CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isUrgent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'add a new task',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isUrgent = !isUrgent;
                });
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isUrgent,
                      fillColor: MaterialStateProperty.all(Colors.white),
                      checkColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (bool? value) {
                        setState(() {
                          isUrgent = value ?? false;
                        });
                      },
                    ),
                    const Text('urgent',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    isUrgent: isUrgent,
                  ),
                );
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    const Color.fromARGB(61, 0, 0, 0)),
                minimumSize: MaterialStateProperty.all(const Size(350, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: const Text('add',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
