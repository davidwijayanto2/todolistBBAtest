import 'package:cloud_firestore/cloud_firestore.dart';

class Friends {
  var fid, uid, email, photoURL, displayName, fbtoken;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Friends(
      {this.fid,
      this.uid,
      this.email,
      this.photoURL,
      this.displayName,
      this.fbtoken});

  Friends.fromMap(Map<String, dynamic> map)
      : fid = map['fid'],
        uid = map['uid'],
        email = map['email'],
        photoURL = map['photoURL'],
        displayName = map['displayName'],
        fbtoken = map['fbtoken'];

  Map<String, dynamic> toMap() => {
        "fid": fid,
        "uid": uid,
        "email": email,
        "photoURL": photoURL,
        "displayName": displayName,
        "fbtoken": fbtoken
      };
  bool setFriend(Friends friend) {
    var result = false;
    try {
      DocumentReference ref = db.collection('friends').doc();
      ref.set({
        'fid': friend.fid,
        'uid': friend.uid,
        'email': friend.email,
        'photoURL': friend.photoURL,
        'displayName': friend.displayName,
        'fbtoken': friend.fbtoken
      }, SetOptions(merge: true));
      result = true;
    } catch (e) {
      print('message: $e');
    }
    return result;
  }

  Stream<QuerySnapshot> getFriendList(_uid) {
    return db.collection('friends').where('uid', isEqualTo: _uid).snapshots();
  }
}
