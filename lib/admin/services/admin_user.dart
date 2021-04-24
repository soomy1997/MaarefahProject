import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUser {
  String uid;
  String email;
  

  AdminUser({
    this.uid,
    this.email,
  });

  AdminUser.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    email = doc.data()['email'];
  }
}
