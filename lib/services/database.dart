import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/models/users.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = 'error';
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': user.name,
        'academicLevel': user.academicLevel,
        'gender': user.gender,
        'email': user.email,
        'role': user.role,
        'phoneNum': user.phoneNum,
        'teachingOverview': user.teachingOverview,
        'avatar_url': user.avatarUrl,
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  final String uid;
  OurDatabase({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('users');
  Future<void> updateUserData(
      String name, String email, String academicLevel) async {
    return await brewCollection.doc(this.uid).set({
      'name': name,
      'email': email,
      'academicLevel': academicLevel,
    });
  }

  Future<OurUser> getuserInfo(String uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection('users').doc(uid).get();
      retVal.uid = uid;
      retVal.academicLevel = _docSnapshot.data()['academicLevel'];
      retVal.email = _docSnapshot.data()['email'];
      retVal.name = _docSnapshot.data()['name'];
      retVal.gender = _docSnapshot.data()['gender'];
      retVal.phoneNum = _docSnapshot.data()['phoneNum'];
      retVal.teachingOverview = _docSnapshot.data()['teachingOverview'];
      retVal.avatarUrl = _docSnapshot.data()['avatar_url'];
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
