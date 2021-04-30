import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_1/component/dialogs.dart';
import 'package:flutter_app_1/screens/TutorDetails.dart' as c;
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
  final DocumentSnapshot post;
  final bool isUserRegistered;
  CourseDetails({this.post, this.isUserRegistered});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
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
      var random = new Random();
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('registration');
        await reference.add({
          'ses_name': '${widget.post.data()["ses_name"]}',
          'l_name': '${_cUser.name}',
          'sessionId': '${widget.post.data()["sessionId"]}',
          'course_name': '${widget.post.data()['course_name']}',
          'academic_level': '${_cUser.academicLevel}',
          'uid': '${_cUser.uid}',
          'reg_id': random.nextInt(100).toString(),
        });
      });
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
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                widget.post.data()['ses_name'],
                style: h4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Image.network(widget.post.data()['image_url']),
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
                            setState(() => _sendToServer());
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return a.AlertDialog1();
                                });
                          } else {
                            setState(() => null);
                          }
                        },
                      )),
          ),
          Expanded(
            child: _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('registration').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.all(7.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 9,
                    child: ListTile(
                      title: Text(
                        'Description',
                        style: h4,
                      ),
                      subtitle: Text(widget.post.data()['ses_description']),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(7.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 9,
                    child: ListTile(
                      title: Text(
                        'Agenda',
                        style: h4,
                      ),
                      subtitle: Text(widget.post.data()['ses_agenda']),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(7.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 9,
                    child: ListTile(
                      title: Text(
                        'Requirements',
                        style: h4,
                      ),
                      subtitle: Text(widget.post.data()['ses_requirement']),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(7.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 70,
                          ),
                          title: Text(
                            'Speaker',
                            style: h4,
                          ),
                          subtitle: Text(
                            widget.post.data()['tutor_name'],
                            style: h5,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            print('cd,m' + widget.post.data().toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyTutorDetails(
                                        //post: widget.post,
                                        post: widget.post.data()['uid'],
                                      )),
                            );

                            // navigateToTutorDetails(
                            //   widget.post
                            //   );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MyTutorDetails(
                            //             //  post: post,
                            //             )));
                          },
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
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
