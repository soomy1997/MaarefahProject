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
    name = doc.data()['name'];
    gender = doc.data()['gender'];
    academicLevel = doc.data()['academicLevel'];
    email = doc.data()['email'];
    role = doc.data()['role'];
    phoneNum = doc.data()['phoneNum'];
    teachingOverview = doc.data()['teachingOverview'];
  }
}
