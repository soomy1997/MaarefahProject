import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/screens/join_as_tutor.dart';
import 'package:flutter_app_1/screens/sign_in_page.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/tutor/add_session.dart';
import 'package:flutter_app_1/utils/constants.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          CurrentUser.saveUser(snapshot.data);
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                final userDoc = snapshot.data;
                final user = userDoc.data();
                if (user['role'] == 'learner' ||
                    user['role'] == 'pending tutor') {
                  return learnerHomeCard();
                } else {
                  return tutorHomeCard();
                }
              });
        }
        return SignInPage();
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSessionPage(),
            ),
          );
        },
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
                    'images/pic5.png',
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
                        'Submit\na new session!',
                        textAlign: TextAlign.center,
                        style: h4,
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 33,
                        vertical: 10,
                      ),
                      child: MaterialButton(
                        color: accentYellow,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddSessionPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.fromLTRB(10, 7.0, 10.0, 7.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'Apply',
                          style: yellowButtonsTextStyle.copyWith(fontSize: 14),
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JoinTutorPage(),
            ),
          );
        },
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
                        horizontal: 10,
                      ),
                      child: Text(
                        'Share your creative \nwork and join us\nas a tutor!',
                        textAlign: TextAlign.center,
                        style: h4,
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: MaterialButton(
                        color: accentYellow,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JoinTutorPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.fromLTRB(10, 7.0, 10.0, 7.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'Join us as Tutor',
                          style: yellowButtonsTextStyle.copyWith(fontSize: 14),
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
