import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/utilities/auth.dart';

class TaskController extends ControllerMVC {
  TaskController([StateMVC state]) : super(state) {
    task = Task();
  }
  Task task;

  bool setTask({category, taskname, reminder, reminder_at, created_at}) {
    Task _task = new Task(
        uid: AuthService.prefs.getString('uid'),
        category: category,
        taskname: taskname,
        reminder: reminder,
        reminder_at: reminder_at,
        created_at: created_at);
    var result = task.setTask(_task);
    return result;
  }

  bool editTask(
      {taskid, category, taskname, reminder, reminder_at, created_at}) {
    Task _task = new Task(
        taskid: taskid,
        uid: AuthService.prefs.getString('uid'),
        category: category,
        taskname: taskname,
        reminder: reminder,
        reminder_at: reminder_at,
        created_at: created_at);
    var result = task.editTask(_task);
    return result;
  }

  Stream<QuerySnapshot> getTaskBetween() {
    return task.getTaskBetween();
  }

  Stream<QuerySnapshot> getAllTask() {
    return task.getAllTask(AuthService.prefs.getString('uid'));
  }

  Stream<DocumentSnapshot> getSingleTask(docId) {
    return task.getSingleTask(docId);
  }

  bool deleteTask({docId}) {
    var result = task.deleteTask(docId);
    return result;
  }

  Future<Map<String, dynamic>> countTaskCategory() async {
    int countpersonal = await task.countTaskCategory(
        'Personal', AuthService.prefs.getString('uid'));
    int countwork = await task.countTaskCategory(
        'Work', AuthService.prefs.getString('uid'));
    int countmeeting = await task.countTaskCategory(
        'Meeting', AuthService.prefs.getString('uid'));
    int countstudy = await task.countTaskCategory(
        'Study', AuthService.prefs.getString('uid'));
    int countshopping = await task.countTaskCategory(
        'Shopping', AuthService.prefs.getString('uid'));
    int countparty = await task.countTaskCategory(
        'Party', AuthService.prefs.getString('uid'));
    return {
      'personal': countpersonal,
      'work': countwork,
      'meeting': countmeeting,
      'study': countstudy,
      'shopping': countshopping,
      'party': countparty,
    };
  }

  Future<int> countTask() async {
    return await task.countTask(AuthService.prefs.getString('uid'));
  }

  Future<int> countTaskToday() async {
    return await task.countTaskToday(AuthService.prefs.getString('uid'));
  }

  Stream<QuerySnapshot> getTodayReminder() {
    return task.getTodayReminder(AuthService.prefs.getString('uid'));
  }
}
