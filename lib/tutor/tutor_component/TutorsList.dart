import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_1/screens/tutorDetails.dart';
import 'package:flutter_app_1/utils/constants.dart';

class TutorsList extends StatefulWidget {
  final title;
  TutorsList({Key key, this.title}) : super(key: key);

  @override
  _TutorsList createState() => _TutorsList();
}

class _TutorsList extends State<TutorsList> {
  navigateToTutorDetails(String post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyTutorDetails(
                  post: post,
                )));
  }

// ignore: must_call_super
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar4(
          context,
          title: "Tutors List",
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where('role', isEqualTo: 'tutor')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              return Center(child: const Text('Loading events...'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: secondaryLightGrey,
                            radius: 45,
                            child: Image.network(
                              snapshot.data.docs[index]['avatar_url'],
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Text(snapshot.data.docs[index]['name'],
                                  style: h4)),
                          new MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              navigateToTutorDetails(
                                  snapshot.data.docs[index]['uid']);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                          )
                        ],
                      ),
                    ));
              },
              itemCount: snapshot.data.docs.length,
            );
          },
        ));
  }
}
