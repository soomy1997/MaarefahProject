import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/services/database.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:flutter_app_1/screens/course_details.dart';
import 'package:flutter_app_1/models/users.dart';

class RegisteredSessions extends StatefulWidget {
  @override
  _RegisteredSessionsState createState() => _RegisteredSessionsState();
}

navigateToCourseDetails(BuildContext context, DocumentSnapshot post) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CourseDetails(
                post: post,
              )));
}

class _RegisteredSessionsState extends State<RegisteredSessions> {
  OurUser _currentUser = OurUser();
  OurUser _cUser = OurUser();

  Future<void> currentUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);

    setState(() {
      _cUser = _currentUser;
    });
  }

  @override
  void initState() {
    super.initState();
    currentUserInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar1(
        context,
        title: "Registered Sessions",
        iconButton: IconButton(
          icon: Icon(Icons.ios_share),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            //child: VerticalCards(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('registration')
                    .where('uid', isEqualTo: _cUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshot.data.docs[index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              child: InkWell(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                doc.data()['image_url'],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 300),
                                            child: Text(
                                              doc.data()['ses_name'],
                                              style: TextStyle(
                                                color: primaryBlack,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 17.0),
                                            child: Text(
                                              'By: ' + doc.data()['tutor_name'],
                                              style: TextStyle(
                                                color: primaryBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 18,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    doc.data()['session_date'],
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Icon(
                                                    Icons.access_time,
                                                    size: 18,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    doc.data()['session_time'],
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // onTap: () {
                                //   navigateToCourseDetails(
                                //     context,
                                //     snapshot.data.docs[index],
                                //   );
                                // },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
