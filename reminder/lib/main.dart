import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/providers/reminder_provider.dart';
import 'package:reminder_app/models/reminder.dart';
import 'package:reminder_app/screens/add_reminder_screen.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(ReminderApp());
}

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReminderProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reminder App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ReminderListScreen(),
      ),
    );
  }
}

class ReminderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddReminderScreen()),
              );
            },
          )
        ],
      ),
      body: Consumer<ReminderProvider>(
        builder: (context, reminderProvider, child) {
          final reminders = reminderProvider.reminders;

          if (reminders.isEmpty) {
            return Center(child: Text('No reminders yet.'));
          }

          return ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return ListTile(
                title: Text(reminder.title),
                subtitle: Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(reminder.dateTime)),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    reminderProvider.removeReminder(reminder.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
