import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/models/users.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(OurUser user) async {
    String retVal = 'error';
    try {
      await _firestore.collection('learners').doc(user.uid).set({
        'uid': user.uid,
        'l_name': user.lName,
        'l_academicLevel': user.lAcademicLevel,
        'l_gender': user.lGender,
        'l_email': user.lEmail,
        'role': user.role,
        // 'avatar': user.avatarName,
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getuserInfo(String uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection('learners').doc(uid).get();
      retVal.uid = uid;
      retVal.lAcademicLevel = _docSnapshot.data()['l_academicLevel'];
      retVal.lEmail = _docSnapshot.data()['l_email'];
      retVal.lName = _docSnapshot.data()['l_name'];
      retVal.lGender = _docSnapshot.data()['l_gender'];
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
