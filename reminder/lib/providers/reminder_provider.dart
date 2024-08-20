import 'package:flutter/material.dart';
import 'package:reminder_app/models/reminder.dart';
import 'dart:collection';

class ReminderProvider with ChangeNotifier {
  final List<Reminder> _reminders = [];

  UnmodifiableListView<Reminder> get reminders =>
      UnmodifiableListView(_reminders);

  void addReminder(Reminder reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void removeReminder(String id) {
    _reminders.removeWhere((reminder) => reminder.id == id);
    notifyListeners();
  }
}
