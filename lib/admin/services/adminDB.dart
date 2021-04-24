import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/admin/services/admin_user.dart';

class AdminDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(AdminUser user) async {
    String retVal = 'error';
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<AdminUser> getuserInfo(String uid) async {
    AdminUser retVal = AdminUser();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection('users').doc(uid).get();
      retVal.uid = uid;
      retVal.email = _docSnapshot.data()['email'];
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
