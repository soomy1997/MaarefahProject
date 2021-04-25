import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/services/database.dart';

class CurrentUser extends ChangeNotifier {
  CurrentUser currentusr;
  OurUser _currentUser = OurUser();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OurUser get getCurrntUser => _currentUser;

  Future<bool> validatePassword(String password) async {
    var firebaseUser = await _auth.currentUser;
    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> validateCurrentPassword(String password) async {
    return await validatePassword(password);
  }

  static saveUser(User user) {
    Map<String, String> userData = {
      "uid": 'user.uid',
      "email": 'user.email',
      "name": 'name',
      "role": "learner",
    };
    return userData;
  }

  //Reset password
  Future sendPassResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Stream<OurUser> getCurrentUser(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((docSnapshot) => OurUser.fromDocumentSnapshot(doc: docSnapshot));
  }

  Future<String> onStartup() async {
    String retVal = 'error';
    try {
      User _firebaseUser = await _auth.currentUser;
      if (_firebaseUser != null) {
        _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);
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

  Future<String> signUpLearner(String email, String password, String name,
      String academicLevel, String gender) async {
    String retVal = 'error';
    OurUser _user = OurUser();
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.name = name;
      _user.academicLevel = academicLevel;
      _user.gender = gender;
      _user.role = 'learner';
      _user.phoneNum = '';
      _user.teachingOverview = '';
      _user.avatarUrl =
          'https://firebasestorage.googleapis.com/v0/b/ma-arefah-app.appspot.com/o/tutoravatars%2FdefaultAvatar.png?alt=media&token=7970deb7-cd62-401c-8e31-7936adb9d454';
      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == 'success') {
        return 'success';
      }
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

      _currentUser = await OurDatabase().getuserInfo(_authResult.user.uid);
      if (_currentUser != null) {
        retVal = 'success';
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
