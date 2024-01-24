import 'package:flutter/material.dart';

class EditTask extends StatefulWidget {
  final String title;
  final String description;
  final bool isUrgent;

  const EditTask({
    required this.title,
    required this.description,
    required this.isUrgent,
    Key? key,
  }) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late bool _isUrgent;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    _isUrgent = widget.isUrgent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            CheckboxListTile(
              title: const Text('Is Urgent'),
              value: _isUrgent,
              onChanged: (bool? value) {
                setState(() {
                  _isUrgent = value!;
                });
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'isUrgent': _isUrgent,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
