import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/services/adminDB.dart';
import 'package:flutter_app_1/admin/services/admin_user.dart';


class CurrentAdmin extends ChangeNotifier {
  AdminUser _currentUser = AdminUser();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AdminUser get getCurrntUser => _currentUser;


  Stream<AdminUser> getCurrentUser(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((docSnapshot) => AdminUser.fromDocumentSnapshot(doc: docSnapshot));
  }

  Future<String> onStartup() async {
    String retVal = 'error';
    try {
      User _firebaseUser = await _auth.currentUser;
      if (_firebaseUser != null) {
        _currentUser = await AdminDatabase().getuserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = 'success';
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';
    try {
      await _auth.signOut();
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> loginUser(String email, String password) async {
    String retVal = 'error';
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _currentUser = await AdminDatabase().getuserInfo(_authResult.user.uid);
      if (_currentUser != null) {
        retVal = 'success';
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
