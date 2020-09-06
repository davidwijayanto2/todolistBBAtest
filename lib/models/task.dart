import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:todolist/utilities/auth.dart';

class Task {
  var taskid, uid, category, taskname, reminder, reminder_at, created_at;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Task(
      {this.taskid,
      this.uid,
      this.category,
      this.taskname,
      this.reminder,
      this.reminder_at,
      this.created_at});

  Task.fromMap(Map<String, dynamic> map)
      : taskid = map['taskid'],
        uid = map['uid'],
        category = map['category'],
        taskname = map['taskname'],
        reminder = map['reminder'],
        reminder_at = map['reminder_at'],
        created_at = map['created_at'];

  Map<String, dynamic> toMap() => {
        "taskid": taskid,
        "uid": uid,
        "category": category,
        "taskname": taskname,
        "reminder": reminder,
        "reminder_at": reminder_at,
        "created_at": created_at,
      };
  bool setTask(Task task) {
    var result = false;
    try {
      DocumentReference ref = db.collection('task').doc();
      ref.set({
        'uid': task.uid,
        'category': task.category,
        'taskname': task.taskname,
        'reminder': task.reminder,
        'reminder_at': task.reminder_at,
        'created_at': FieldValue.serverTimestamp()
      }, SetOptions(merge: true));
      result = true;
    } catch (e) {
      print('message: $e');
    }
    return result;
  }

  bool editTask(Task task) {
    var result = false;
    try {
      DocumentReference ref = db.collection('task').doc(task.taskid);
      ref.update({
        'uid': task.uid,
        'category': task.category,
        'taskname': task.taskname,
        'reminder': task.reminder,
        'reminder_at': task.reminder_at,
      });
      result = true;
    } catch (e) {
      print('message: $e');
    }
    return result;
  }

  bool deleteTask(docId) {
    var result = false;
    try {
      db.collection('task').doc(docId).delete();
      result = true;
    } catch (e) {
      print('mesage: $e');
    }
    return result;
  }

  Stream<QuerySnapshot> getAllTask(_uid) {
    var now = DateTime.parse(
        DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.now()));
    return db
        .collection('task')
        .where('reminder_at', isGreaterThanOrEqualTo: now)
        .where('uid', isEqualTo: _uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getTaskBetween() {
    var now = DateTime.parse(
        DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.now()));
    var tomorrow = DateTime.parse(DateFormat('yyyy-MM-dd 23:59:59')
        .format(DateTime.now().add(Duration(days: 1))));

    return db
        .collection('task')
        .where('reminder_at', isGreaterThanOrEqualTo: now)
        .where('reminder_at', isLessThanOrEqualTo: tomorrow)
        .snapshots();
  }

  Stream<DocumentSnapshot> getSingleTask(_docId) {
    return db.collection('task').doc(_docId).snapshots();
  }

  Future<int> countTaskCategory(_category, _uid) async {
    var length = await db
        .collection('task')
        .where('category', isEqualTo: _category)
        .where('uid', isEqualTo: _uid)
        .get()
        .then((value) {
      return value.docs.length;
    });
    return length;
  }

  Future<int> countTask(_uid) async {
    var now = DateTime.parse(
        DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.now()));
    var length = await db
        .collection('task')
        .where('reminder_at', isGreaterThanOrEqualTo: now)
        .where('uid', isEqualTo: _uid)
        .get()
        .then((value) {
      return value.docs.length;
    });
    return length;
  }

  Future<int> countTaskToday(_uid) async {
    var start = DateTime.parse(
        DateFormat('yyyy-MM-dd 00:00:00').format(DateTime.now()));
    var end = DateTime.parse(
        DateFormat('yyyy-MM-dd 23:59:59').format(DateTime.now()));
    var length = await db
        .collection('task')
        .where('reminder_at', isGreaterThanOrEqualTo: start)
        .where('reminder_at', isLessThanOrEqualTo: end)
        .where('uid', isEqualTo: _uid)
        .get()
        .then((value) {
      if (value.docs != null) {
        return value.docs.length;
      } else {
        return 0;
      }
    });
    return length;
  }

  Stream<QuerySnapshot> getTodayReminder(_uid) {
    var now = DateTime.now();
    var end = DateTime.parse(
        DateFormat('yyyy-MM-dd 23:59:59').format(DateTime.now()));
    return db
        .collection('task')
        .where('reminder_at', isGreaterThanOrEqualTo: now)
        .where('reminder_at', isLessThanOrEqualTo: end)
        .where('uid', isEqualTo: _uid)
        .orderBy('reminder_at')
        .limit(1)
        .snapshots();
  }
}
