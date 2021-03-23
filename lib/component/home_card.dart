import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/join_as_tutor.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/utils/constants.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          CurrentUser.saveUser(snapshot.data);
          return <StreamBuilderDocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("learners")
                .doc(snapshot.data.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final userDoc = snapshot.data;
                final user = userDoc.data();
                if (user['role'] == 'learner') {
                  return learnerHomeCard();
                } else {
                  return tutorHomeCard();
                }
              } else {
                return Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          );
        }
        return learnerHomeCard();
      },
    );
  }

  Widget tutorHomeCard() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 160,
      child: InkWell(
        // onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: 'product.id',
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  height: 160,
                  child: Image.asset(
                    'images/pic4.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 15,
              child: SizedBox(
                height: 136,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        'submit\na new session!',
                        textAlign: TextAlign.center,
                        style: h1,
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 70,
                      ),
                      child: MaterialButton(
                        color: Color(0xffF9A21B),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JoinTutorPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                        child: Text(
                          'Apply',
                          style: yellowButtonsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget learnerHomeCard() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: 160,
      child: InkWell(
        // onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: 'product.id',
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  height: 160,
                  child: Image.asset(
                    'images/pic4.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 15,
              child: SizedBox(
                height: 136,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        'Join Us as \nTutor !',
                        textAlign: TextAlign.center,
                        style: h1,
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      child: MaterialButton(
                        color: Color(0xffF9A21B),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JoinTutorPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                        child: Text(
                          'Request for Tutor',
                          style: yellowButtonsTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
