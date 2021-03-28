import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String name;
  String gender;
  String academicLevel;
  String email;
  String role;
  String phoneNum;
  String teachingOverview;

  OurUser({
    this.uid,
    this.name,
    this.gender,
    this.academicLevel,
    this.email,
    this.role,
    this.phoneNum,
    this.teachingOverview,
  });

  OurUser.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    name = doc.data()['l_name'];
    gender = doc.data()['l_gender'];
    academicLevel = doc.data()['l_academicLevel'];
    email = doc.data()['l_email'];
    role = doc.data()['role'];
    phoneNum = doc.data()['phoneNum'];
    teachingOverview = doc.data()['teachingOverview'];
  }
}
