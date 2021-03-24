import 'package:cloud_firestore/cloud_firestore.dart';

class Session {
  String sessionID;
  String sessionName;
  String tutorName;

  Session({
    this.sessionID,
    this.sessionName,
    this.tutorName,
  });

  Session.fromDocumentSnapshot({DocumentSnapshot doc}) {
    sessionID = doc.data()['sessionID'];
    sessionName = doc.data()['sessionName'];
    tutorName = doc.data()['tutorName'];
  }
}
