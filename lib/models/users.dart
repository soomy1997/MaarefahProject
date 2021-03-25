import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String lName;
  String lGender;
  String lAcademicLevel;
  String lEmail;
  String role;

  OurUser({
    this.uid,
    this.lName,
    this.lGender,
    this.lAcademicLevel,
    this.lEmail,
    this.role,
  });

  OurUser.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    lName = doc.data()['l_name'];
    lGender = doc.data()['l_gender'];
    lAcademicLevel = doc.data()['l_academicLevel'];
    lEmail = doc.data()['l_email'];
    role = doc.data()['role'];
  }
}
