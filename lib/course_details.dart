import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:flutter_app_1/component/successful_register_dialog.dart' as a;
import 'package:cloud_firestore/cloud_firestore.dart';

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
                MaterialButton(
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
                    side: BorderSide(color: Colors.black54),
                  ),
                  color: Colors.white,
                  child: Text(
                    ' Add to Calendar',
                    style: whiteButtonsTextStyle,
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
      …