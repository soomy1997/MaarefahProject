import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_1/admin/admin_compnent/main_drawer.dart';
import 'package:flutter_app_1/admin/session_requests.dart';
import 'package:flutter_app_1/utils/constants.dart';
import '../component/dialogs.dart';
import 'package:intl/intl.dart';

class SessionDetailsPage extends StatefulWidget {
  final String id;
  SessionDetailsPage({@required this.id});

  @override
  _SessionDetailsPage createState() => _SessionDetailsPage(id: this.id);
}

class _SessionDetailsPage extends State<SessionDetailsPage> {
  final String id;
  _SessionDetailsPage({@required this.id});

  String stateGroupValue = '';

  bool approvalstate = false;

  bool isStateSelected = false;

  DateTime selectedDate = DateTime.now();
  String formattedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget build(BuildContext context) {
    Widget table() {
      return SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('session')
              .where('sessionId', isEqualTo: this.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            return Table(
              columnWidths: {
                0: FlexColumnWidth(15),
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
                          'Session ID',
                          style: h4,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["sessionId"],
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
                            'Session Name',
                            style: h4,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["ses_name"],
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
                            'Session Type',
                            style: h4,
                          )),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["ses_type"],
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
                          'Course Name',
                          style: h4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["course_name"],
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
                          'Session Discribtion',
                          style: h4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["ses_description"],
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
                        'Agenda',
                        style: h4,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        snapshot.data.docs.first.data()["ses_agenda"],
                      ),
                    ),
                  ],
                ),
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
                        'Location',
                        style: h4,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        snapshot.data.docs.first.data()["ses_location"],
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
                          'Requirements',
                          style: h4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["ses_requirement"],
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
                          'Level',
                          style: h4,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          snapshot.data.docs.first.data()["academic_level"],
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
                          'Tutor Name',
                          style: h4,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["tutor_name"],
                          )),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey.shade300))),
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(children: [
                          Text('State', style: h4),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.grey,
                          )
                        ]),
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Radio(
                                  value: 'shown',
                                  groupValue: stateGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      stateGroupValue = val;
                                      isStateSelected = true;
                                    });
                                  }),
                              Text('Shown'),
                              Radio(
                                  value: 'hidden',
                                  groupValue: stateGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      stateGroupValue = val;
                                      isStateSelected = true;
                                    });
                                  }),
                              Text('Hidden'),
                            ],
                          )),
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
                            'Suitable Days',
                            style: h4,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["session_day"],
                          )),
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
                            'Suitable Times',
                            style: h4,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["session_time"],
                          )),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Colors.grey.shade300))),
                    children: [
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Row(children: [
                            Text('Date', style: h4),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.grey,
                            )
                          ])),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                                "${formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate)}"),
                            SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                              onPressed: () => _selectDate(context),
                              child: Text(
                                'Select date',
                                style: TextStyle(color: accentYellow),
                              ),
                            )
                          ],
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
                            'image url',
                            style: h4,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            snapshot.data.docs.first.data()["image_url"],
                          )),
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
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        disabledColor: Colors.grey,
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(context, 'Sure?',
              'Are you sure you want\n to approve this session?');
          if (action == DialogAction.yes) {
            FirebaseFirestore.instance
                .collection('session')
                .where('sessionId', isEqualTo: this.id)
                .get()
                .then((value) => value.docs.forEach((element) {
                      element.reference.update({
                        'approved': 'yes',
                        'state': '$stateGroupValue',
                        'ses_date':
                            '${formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate)}',
                      }).then(
                        (value) => print('Success!'),
                      );
                    }));
            setState(() {
              approvalstate = true;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SessionRequestPage(),
              ),
            );
          } else {
            setState(() => null);
          }
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
        onPressed: () async {
          final action = await WarningDialogs.yesAbortDialog(context,
              'Warning!', 'Are you sure you want to reject this request?');
          if (action == DialogAction.yes) {
            FirebaseFirestore.instance
                .collection('session')
                .where('sessionId', isEqualTo: this.id)
                .get()
                .then((value) {
              value.docs.forEach((element) {
                element.reference.delete().then((value) {
                  print('Success!');
                });
              });
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SessionRequestPage(),
              ),
            );
          } else {
            setState(() => null);
          }
        },
        child: Text("Reject",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Session Details',
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
                    'This session is Approved',
                    style: h4.copyWith(color: Colors.green.shade800),
                  )
                : Text(
                    'This session needs approval...',
                    style: h4.copyWith(color: Colors.grey),
                  ),
          ),
          table(),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                approveButton,
                SizedBox(
                  width: 10,
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
