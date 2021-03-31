import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/services/database.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser = OurUser();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OurUser get getCurrntUser => _currentUser;

  // static saveUser(User user) {
  //   Map<String, String> userData = {
  //     "uid": 'user.uid',
  //     "email": 'user.email',
  //     "name": 'name',
  //     "role": "learner",
  //   };
  //   return userData;
  // }

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

// class AuthenticationService {
//   final FirebaseAuth _firebaseAuth;
//   AuthenticationService(this._firebaseAuth);

//   Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

//   // GET UID
//   Future<String> getCurrentUID() async {
//     return (_firebaseAuth.currentUser).uid;
//   }

//   // GET CURRENT USER
//   Future getCurrentUser() async {
//     return await _firebaseAuth.currentUser;
//   }

//   // check if the user signed in
//   Future<bool> isUserSignedIn() async {
//     var user = _firebaseAuth.currentUser;
//     return user != null;
//   }

//   // Sign out
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }

//   // Email & Password Sign In
//   Future<String> signIn({String email, String password}) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       return 'Signed in';
//     } on FirebaseAuthException catch (e) {
//       print(e);
//       return e.message;
//     }
//   }

//   // Email & Password Sign Up
//   Future<String> signUp(String email, String password) async {
//     try {
//       UserCredential result = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       User user = result.user;
//       //return _userFrom
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
// }
