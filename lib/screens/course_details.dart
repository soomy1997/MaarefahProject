import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:flutter_app_1/component/successful_register_dialog.dart' as a;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/tutorDetails.dart';

class CourseDetails extends StatefulWidget {
  final DocumentSnapshot post;
  CourseDetails({this.post});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  navigateToTutorDetails(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyTutorDetails(
                  post: post,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar1(
        context,
        title: "Course Details",
        iconButton: IconButton(
          icon: Icon(Icons.ios_share),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                widget.post.data()['course_name'],
                style: h4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Image.network(widget.post.data()['image_url']),
            height: 180,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  highlightColor: Color(0xffB36D05),
                  height: 50,
                  minWidth: 190,
                  color: accentYellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ' Register Session',
                    style: yellowButtonsTextStyle,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return a.AlertDialog();
                      },
                    );
                  },
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 190,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  color: Colors.white,
                  child: Text(
                    'Zoom Meeting',
                    style: whiteButtonsTextStyle.copyWith(
                        color: Colors.indigoAccent.shade700),
                  ),
                  onPressed: () {},
                )
              ],
            ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('View Profile'),
                              onPressed: () {
                                navigateToTutorDetails(
                                  widget.post.data()['tutor_name'],
                                );
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  navigateToTutorDetails(
                                    widget.post.data()['tutor_name'],
                                  );
                                }),
                          ],
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
