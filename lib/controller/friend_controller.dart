import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/models/friends.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/models/users.dart';

class FriendController extends ControllerMVC {
  FriendController([StateMVC state]) : super(state) {
    friend = Friends();
    user = Users();
    task = Task();
  }
  Friends friend;
  Users user;
  Task task;

  bool setFriend({fid, uid, email, photoURL, displayName, fbtoken}) {
    Friends _friend = new Friends(
        fid: fid,
        uid: uid,
        email: email,
        photoURL: photoURL,
        displayName: displayName,
        fbtoken: fbtoken);
    var result = friend.setFriend(_friend);
    return result;
  }

  bool setTaskToFriend(
      {uid, category, taskname, reminder, reminder_at, created_at}) {
    Task _task = new Task(
        uid: uid,
        category: category,
        taskname: taskname,
        reminder: reminder,
        reminder_at: reminder_at,
        created_at: created_at);
    var result = task.setTask(_task);
    return result;
  }

  Stream<QuerySnapshot> getFriendLIst(uid) {
    return friend.getFriendList(uid);
    //var userlist = user.getUser(uid);
  }

  Stream<QuerySnapshot> getUser(uid) {
    return user.getUser(uid);
    //var userlist = user.getUser(uid);
  }

  Stream<QuerySnapshot> getSearchUser(displayName) {
    return user.getUserName(displayName);
    //var userlist = user.getUser(uid);
  }
}
