import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/providers/reminder_provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  void _submitReminder() {
    if (_titleController.text.isEmpty || _selectedDate == null) {
      return;
    }

    final reminder = Reminder(
      id: Uuid().v4(),
      title: _titleController.text,
      dateTime: _selectedDate!,
    );

    Provider.of<ReminderProvider>(context, listen: false).addReminder(reminder);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text('Choose Date'),
                )
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReminder,
              child: Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
