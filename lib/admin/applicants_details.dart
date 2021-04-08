import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_1/utils/constants.dart';

import 'admin_compnent/main_drawer.dart';

class ApplicantsDetailsPage extends StatefulWidget {
  final String id;
  ApplicantsDetailsPage({@required this.id});

  @override
  _ApplicantsDetailsPage createState() => _ApplicantsDetailsPage(id: this.id);
}

class _ApplicantsDetailsPage extends State<ApplicantsDetailsPage> {
  final String id;
  _ApplicantsDetailsPage({@required this.id});

  String stateGroupValue = '';

  bool approvalstate = false;

  bool isStateSelected = false;

  Widget build(BuildContext context) {
    Widget table() {
      return SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('tutoring_request')
              .where('uid', isEqualTo: this.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return Table(
              columnWidths: {
                0: FlexColumnWidth(17),
                1: FlexColumnWidth(25),
              },
              children: [
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey.shade300))),
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Applicant ID',
                          style: h4,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["uid"],
                          )),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1.0, color: Colors.grey.shade300),
                      ),
                    ),
                    children: [
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Applicant Name',
                            style: h4,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["name"],
                          )),
                    ]),
                TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1.0, color: Colors.grey.shade300),
                    ),
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Acadmic Level',
                        style: h4,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        snapshot.data.docs.first.data()["academicLevel"],
                      ),
                    ),
                  ],
                ),
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey.shade300))),
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Email',
                          style: h4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["email"],
                        ),
                      ),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey.shade300))),
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Gender',
                          style: h4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["gender"],
                        ),
                      ),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey.shade300))),
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Phone No',
                          style: h4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["phoneNo"],
                        ),
                      ),
                    ]),
              ],
            );
          },
        ),
      );
    }

    final approveButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentYellow,
      child: MaterialButton(
        height: 50,
        minWidth: 190,
        disabledColor: Colors.grey,
        onPressed: () {
          setState(() {
            approvalstate = true;
          });
        },
        child: Text("Approve",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    final rejectButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentOrange,
      child: MaterialButton(
        height: 50,
        minWidth: 190,
        disabledColor: Colors.grey,
        onPressed: () {},
        child: Text("Reject",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Applicants Details',
      ),
      endDrawer: Drawer(
        child: MainDrawer(),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12, 25, 12, 12),
            child: approvalstate
                ? Text(
                    'This request is approved',
                    style: h4.copyWith(color: Colors.green.shade800),
                  )
                : Text(
                    'This request needs approval...',
                    style: h4.copyWith(color: Colors.grey),
                  ),
          ),
          table(),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                approveButton,
                SizedBox(
                  width: 20,
                ),
                rejectButton
              ],
            ),
          )
        ],
      )),
    );
  }
}
