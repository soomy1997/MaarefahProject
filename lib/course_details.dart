import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_1/component/home_card.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/home_page.dart';

class CourseDetails extends StatefulWidget {
  final DocumentSnapshot post;
  CourseDetails({this.post});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryDarkBlue,
        title: Text(
          'Session Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          new IconButton(
            icon: Icon(Icons.ios_share),
            iconSize: 30,
            onPressed: () => (0),
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'return to previous screen',
            onPressed: () {
              Navigator.pop(context);
            }),
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
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/ma-arefah-app.appspot.com/o/" +
                  widget.post.data()['image_name'] +
                  "?alt=media&token=" +
                  widget.post.data()['imageToken'],
            ),
            height: 180,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  height: 50,
                  minWidth: 190,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  onPressed: () {},
                  child: Text(
                    ' Register Session',
                    style: yellowButtonsTextStyle,
                  ),
                  color: accentYellow,
                ),
                FlatButton(
                  height: 50,
                  minWidth: 190,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: Colors.black54),
                  ),
                  child: Text(
                    ' Add to Calendar',
                    style: whiteButtonsTextStyle,
                  ),
                  color: Colors.white,
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
        stream: FirebaseFirestore.instance
            .collection('session')
            .doc('9dUB3qHf13otyFLJIy51')
            .snapshots(),
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
                    height: MediaQuery.of(context).size.height / 9,
                    child: ListTile(
                      title: Text(
                        'Attachments',
                        style: h4,
                      ),
                      subtitle: Text(widget.post.data()['ses_attachment']),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            size: 70,
                          ),
                          title: Text(widget.post.data()['tutor_name']),
                          subtitle: Text(widget.post.data()['tutor_overview']),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('View Profile'),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {}),
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
