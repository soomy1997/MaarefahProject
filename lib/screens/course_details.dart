import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_1/component/dialogs.dart';
import 'dart:math';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:flutter_app_1/admin/admin_compnent/successful_register_dialog.dart'
    as a;
import 'package:flutter_app_1/admin/admin_compnent/share_popup.dart' as b;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:url_launcher/url_launcher.dart';

import 'tutorDetails.dart';

class CourseDetails extends StatefulWidget {
  final String post;
  final bool isUserRegistered;
  CourseDetails({this.post, this.isUserRegistered});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

// Future<String> tutorNameByUid() async {
//   var sessions = await FirebaseFirestore.instance
//       .collection("users")
//       .where("uid", isEqualTo: widget.post)
//       .limit(1)
//       .get();
//   var tt_name = sessions.docs[0].data()['name'];
//   return tt_name;
// }

class _CourseDetailsState extends State<CourseDetails> {
  Future<DocumentSnapshot> getSessioninformation() async {
    var sess = await FirebaseFirestore.instance
        .collection('session')
        .where('sessionId', isEqualTo: widget.post)
        .limit(1)
        .get();
    return sess.docs[0];
  }

  // Future<String> sessionNameByUid() async {
  //   var sessions = await FirebaseFirestore.instance
  //       .collection("session")
  //       .where("sessionId", isEqualTo: widget.post.data()['sessionId'])
  //       .limit(1)
  //       .get();
  //   var tt_name = sessions.docs[0].data()['name'];
  //   return tt_name;
  // }

  navigateToTutorDetails(String post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyTutorDetails(
                  post: post,
                )));
  }

  //getting current user information
  OurUser _currentUser = OurUser();
  OurUser _cUser;
  OurUser get getCurrntUser => _currentUser;
  Future<void> getUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);
    setState(() {
      _cUser = _currentUser;
    });
  }

  User user;
  Future<void> getUserData() async {
    User userData = FirebaseAuth.instance.currentUser;
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    print("from course details " + widget.isUserRegistered.toString());
    void _sendToServer() {
      // FirebaseFirestore.instance
      //     .runTransaction((Transaction transaction) async {
      //   CollectionReference reference =
      //       FirebaseFirestore.instance.collection('registration');
      //   await reference.add({
      //     'ses_name': '${snapshot.data["ses_name"]}',
      //     'image_url': '${snapshot.data["image_url"]}',
      //     'l_name': '${_cUser.name}',
      //     'tutor_name': '${snapshot.data["tutor_name"]}',
      //     'ses_date': '${snapshot.data["ses_date"]}',
      //     'session_time': '${snapshot.data["session_time"]}',
      //     'sessionId': '${snapshot.data["sessionId"]}',
      //     'course_name': '${snapshot.data['course_name']}',
      //     'academic_level': '${_cUser.academicLevel}',
      //     'uid': '${_cUser.uid}'
      //   });
      // });
    }

    return Scaffold(
        appBar: myAppBar1(
          context,
          title: "Course Details",
          iconButton: IconButton(
            icon: Icon(Icons.ios_share),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return b.ShareDialog1();
                },
              );
            },
          ),
        ),
        body: FutureBuilder(
            future: getSessioninformation(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              } else {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          snapshot.data['ses_name'],
                          style: h4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      child: Image.network(snapshot.data['image_url']),
                      height: 180,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: widget.isUserRegistered
                            ? MaterialButton(
                                height: 50,
                                minWidth: 200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                color: Colors.white,
                                child: Text(
                                  'Zoom Meeting',
                                  style: whiteButtonsTextStyle.copyWith(
                                      color: Colors.indigoAccent.shade700),
                                ),
                                onPressed: () {
                                  const url =
                                      "https://us04web.zoom.us/j/76518082507?pwd=TE5ISzJ1UEdPMlNTK05ETTdZa1JKUT09";
                                  if (canLaunch(url) != null) launch(url);
                                },
                              )
                            : MaterialButton(
                                highlightColor: accentOrange,
                                height: 50,
                                minWidth: 200,
                                color: accentYellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  ' Register Session',
                                  style: yellowButtonsTextStyle,
                                ),
                                onPressed: () async {
                                  final action = await Dialogs.yesAbortDialog(
                                      context,
                                      "Sure?",
                                      "Are you sure you want to \nregister in this session?");
                                  if (action == DialogAction.yes) {
                                    setState(() => FirebaseFirestore.instance
                                            .runTransaction((Transaction
                                                transaction) async {
                                          CollectionReference reference =
                                              FirebaseFirestore.instance
                                                  .collection('registration');
                                          await reference.add({
                                            'ses_name':
                                                '${snapshot.data["ses_name"]}',
                                            'image_url':
                                                '${snapshot.data["image_url"]}',
                                            'l_name': '${_cUser.name}',
                                            'tutor_name':
                                                '${snapshot.data["tutor_name"]}',
                                            'ses_date':
                                                '${snapshot.data["ses_date"]}',
                                            'session_time':
                                                '${snapshot.data["session_time"]}',
                                            'sessionId':
                                                '${snapshot.data["sessionId"]}',
                                            'course_name':
                                                '${snapshot.data['course_name']}',
                                            'academic_level':
                                                '${_cUser.academicLevel}',
                                            'uid': '${_cUser.uid}'
                                          });
                                        }));
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return a.AlertDialog1();
                                        });
                                  } else {
                                    setState(() => null);
                                  }
                                },
                              ),
                      ),
                    ),
                    Expanded(
                      child: _buildListView(),
                    ),
                  ],
                );
              }
            }));
  }

  Widget _buildListView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: getSessioninformation(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
            //print('this is string ' + snapshot.data.length.toString());
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 8,
                      child: ListTile(
                        title: Text(
                          'Description',
                          style: h4,
                        ),
                        subtitle: Text(
                          snapshot.data['ses_description'],
                          style: h5,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 8,
                      child: ListTile(
                        title: Text(
                          'Agenda',
                          style: h4,
                        ),
                        subtitle: Text(snapshot.data['ses_agenda'], style: h5),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 8,
                      child: ListTile(
                        title: Text(
                          'Requirements',
                          style: h4,
                        ),
                        subtitle:
                            Text(snapshot.data['ses_requirement'], style: h5),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(snapshot.data['avatar_url']),
                            ),
                            title: Text(
                              'Speaker',
                              style: h4,
                            ),
                            subtitle: Text(
                              snapshot.data['tutor_name'],
                              style: h5,
                            ),
                          ),
                          MaterialButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new Text(
                                  "View Profile ",
                                  style: whiteButtonsTextStyle,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: kTextLightColor,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyTutorDetails(
                                          post: snapshot.data['uid'],
                                        )),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

/* _sendToServer();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return a.AlertDialog1();*/
