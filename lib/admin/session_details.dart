import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_1/utils/constants.dart';

class SessionDetailsPage extends StatefulWidget {
  final String id;
  SessionDetailsPage({@required this.id});

  @override
  _SessionDetailsPage createState() => _SessionDetailsPage(id: this.id);
}

class _SessionDetailsPage extends State<SessionDetailsPage> {
  
  final userRef = FirebaseFirestore.instance.collection('users');

  final String id;
  _SessionDetailsPage({@required this.id});

  String stateGroupValue = '';

  bool approvalstate = false;

  bool isStateSelected = false;

  DateTime selectedDate = DateTime.now();

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
        padding: EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('add_session_request')
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
                            snapshot.data.docs.first.data()["sessionName"],
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
                          snapshot.data.docs.first.data()["session_type"],
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
                          snapshot.data.docs.first
                              .data()["session_description"],
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
                        'lorem ipsum',
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
                        snapshot.data.docs.first.data()["session_location"],
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
                          snapshot.data.docs.first
                              .data()["session_requirements"],
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
                            snapshot.data.docs.first.data()["tutorName"],
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
                            snapshot.data.docs.first
                                .data()["suitable_tutoring_days"],
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
                            snapshot.data.docs.first
                                .data()["suitable_session_times"],
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
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text("${selectedDate.toLocal()}".split(' ')[0]),
                            SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                              onPressed: () => _selectDate(context),
                              child: Text('Select date'),
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
                            'Attachements',
                            style: h4,
                          )),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
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
        padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
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
        padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
        disabledColor: Colors.grey,
        onPressed: () {},
        child: Text("Reject",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );

    return Scaffold(
      appBar: myAppBar1(
        context,
        title: 'Session Details',
        iconButton: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {},
        ),
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
            padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
