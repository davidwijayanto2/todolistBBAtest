import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  var uid, email, photoURL, displayName, fbtoken;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Users({this.uid, this.email, this.photoURL, this.displayName, this.fbtoken});

  Users.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        email = map['email'],
        photoURL = map['photoURL'],
        displayName = map['displayName'],
        fbtoken = map['fbtoken'];

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "photoURL": photoURL,
        "displayName": displayName,
        "fbtoken": fbtoken
      };
  bool setUserData(Users user) {
    var result = false;
    try {
      DocumentReference ref = db.collection('users').doc(user.uid);
      ref.set({
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoURL,
        'displayName': user.displayName,
        'fbtoken': user.fbtoken
      }, SetOptions(merge: true));
      result = true;
    } catch (e) {
      print('message: $e');
    }
    return result;
  }

  Stream<QuerySnapshot> getUser(uid) {
    return db.collection('users').snapshots();
  }

  Stream<QuerySnapshot> getUserName(displayName) {
    print(displayName);
    return db
        .collection('users')
        .where('displayName', isEqualTo: displayName)
        .snapshots();
  }
}
