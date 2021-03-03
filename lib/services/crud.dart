import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> AddData(someData) async {
    if (isLoggedIn()) {
      FirebaseFirestore.instance
          .collection('testingcrud')
          .add(someData)
          .catchError((e) {
        print(e);
      });
    } else {
      print('You need to belogged in');
    }
  }

  getData() async {
    return await FirebaseFirestore.instance.collection('tutors').get();
  }
}
