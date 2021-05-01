import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_1/component/dialogs.dart';
import 'package:flutter_app_1/admin/manage_session.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'admin_compnent/main_drawer.dart';

class EditSessionDetailsPage extends StatefulWidget {
  final String id;
  EditSessionDetailsPage({@required this.id});

  @override
  _EditSessionDetailsPage createState() => _EditSessionDetailsPage(id: this.id);
}

class _EditSessionDetailsPage extends State<EditSessionDetailsPage> {
  final String id;
  _EditSessionDetailsPage({@required this.id});
  final format = DateFormat("dd-MM-yyyy");
  String formattedDate;
  String locationValueChoose,
      sessionTypeValueChoose,
      levelValueChoose,
      typeValueChoose,
      coursesValueChoose,
      sessionName,
      sessionDescription,
      sessionAgenda,
      sesssionRequirements,
      tutorName;

  DateTime sessionDate;

  List coursesList = [
    'CS321 Object Oriented Programming 1',
    'MATH 311: Discrete Math',
    'CS532: Database Design',
    'Operating Systems',
    'Java Programming: 2 Books in 1',
  ];
  List levelList = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  List sessionTypes = ["College Courses", "Additional Skills Courses"];
  List locationlList = ["Physical", "Online"];
  List statelList = ["shown", "hidden"];
  bool approvalstate = false;
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Widget table() {
      return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('session')
                  .where('sessionId', isEqualTo: this.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                TextEditingController sesDate = TextEditingController(
                    text: snapshot.data.docs.first.data()['ses_date']);
                return Form(
                  key: _formKey,
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(15),
                      1: FlexColumnWidth(25),
                    },
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Session ID',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(snapshot.data.docs.first
                                    .data()['sessionId'])),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Session Name',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  obscureText: false,
                                  validator: textAreaValidation2,
                                  initialValue: snapshot.data.docs.first
                                      .data()['ses_name'],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      sessionName = value;
                                    });
                                  },
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Session Type',
                                  style: h4,
                                )),
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                hint: Text('ses_type'),
                                icon: Icon(Icons.arrow_drop_down),
                                style: h5,
                                isExpanded: true,
                                validator: (value) => value == null
                                    ? '   This field is required'
                                    : null,
                                value:
                                    snapshot.data.docs.first.data()['ses_type'],
                                onChanged: (newValue) {
                                  setState(() {
                                    typeValueChoose = newValue;
                                  });
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    typeValueChoose = newValue;
                                  });
                                },
                                items: sessionTypes.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(
                                      valueItem,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Course Name',
                                  style: h4,
                                )),
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                              child: snapshot.data.docs.first
                                          .data()['ses_type'] ==
                                      'Additional Skills Courses'
                                  ? TextFormField(
                                      obscureText: false,
                                      validator: textAreaValidation2,
                                      initialValue: 'Not Applicable',
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Icon(
                                          Icons.edit,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  : DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      hint: Text('Course Name'),
                                      icon: Icon(Icons.arrow_drop_down),
                                      style: h5,
                                      isExpanded: true,
                                      validator: (value) => value == null
                                          ? '   This field is required'
                                          : null,
                                      value: snapshot.data.docs.first
                                          .data()['course_name'],
                                      onSaved: (course) {
                                        setState(() {
                                          coursesValueChoose = course;
                                        });
                                      },
                                      items: coursesList.map((valueItem2) {
                                        return DropdownMenuItem(
                                          value: valueItem2,
                                          child: Text(valueItem2,
                                              style: TextStyle(fontSize: 16)),
                                        );
                                      }).toList(),
                                    ),
                            ),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Session Description',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  obscureText: false,
                                  validator: textAreaValidation2,
                                  initialValue: snapshot.data.docs.first
                                      .data()['ses_description'],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      sessionDescription = value;
                                    });
                                  },
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Agenda',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  obscureText: false,
                                  validator: textAreaValidation2,
                                  initialValue: snapshot.data.docs.first
                                      .data()['ses_agenda'],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  onSaved: (value) {
                                    sessionAgenda = value;
                                  },
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Location',
                                  style: h4,
                                )),
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                hint: Text('session location'),
                                icon: Icon(Icons.arrow_drop_down),
                                style: h5,
                                isExpanded: true,
                                validator: (value) => value == null
                                    ? '   This field is required'
                                    : null,
                                value: snapshot.data.docs.first
                                    .data()['ses_location'],
                                onChanged: (newValue) {
                                  setState(() {
                                    locationValueChoose = newValue;
                                  });
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    locationValueChoose = newValue;
                                  });
                                },
                                items: locationlList.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(
                                      valueItem,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Requirements',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  obscureText: false,
                                  validator: textAreaValidation2,
                                  initialValue: snapshot.data.docs.first
                                      .data()['ses_requirement'],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  onSaved: (value) {
                                    setState(() {
                                      sesssionRequirements = value;
                                    });
                                  },
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Level',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                                child: DropdownButtonFormField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  hint: Text('Academic Level'),
                                  icon: Icon(Icons.arrow_drop_down),
                                  style: h5,
                                  isExpanded: true,
                                  validator: (value) => value == null
                                      ? '   This field is required'
                                      : null,
                                  value: snapshot.data.docs.first
                                      .data()['academic_level'],
                                  onChanged: (newValue1) {
                                    setState(() {
                                      levelValueChoose = newValue1;
                                    });
                                  },
                                  onSaved: (newValue1) {
                                    setState(() {
                                      levelValueChoose = newValue1;
                                    });
                                  },
                                  items: levelList.map((valueItem1) {
                                    return DropdownMenuItem(
                                      value: valueItem1,
                                      child: Text(valueItem1,
                                          style: TextStyle(fontSize: 16)),
                                    );
                                  }).toList(),
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Tutor Name',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: TextFormField(
                                  obscureText: false,
                                  validator: textAreaValidation2,
                                  initialValue: snapshot.data.docs.first
                                      .data()['tutor_name'],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  onSaved: (value) {
                                    tutorName = value;
                                  },
                                )),
                          ]),
                      // TableRow(
                      //     decoration: BoxDecoration(
                      //         border: Border(
                      //             bottom: BorderSide(
                      //                 width: 1.0,
                      //                 color: Colors.grey.shade300))),
                      //     children: [
                      //       Container(
                      //           padding: EdgeInsets.all(15),
                      //           child: Row(children: [
                      //             Text('State', style: h4),
                      //             SizedBox(
                      //               width: 5,
                      //             ),
                      //           ])),
                      //       Container(
                      //           padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                      //           child: DropdownButtonFormField(
                      //             decoration:
                      //                 InputDecoration(border: InputBorder.none),
                      //             hint: Text('State'),
                      //             icon: Icon(Icons.arrow_drop_down),
                      //             style: h5,
                      //             isExpanded: true,
                      //             validator: (value) => value == null
                      //                 ? '   This field is required'
                      //                 : null,
                      //             value:
                      //                 snapshot.data.docs.first.data()['state'],
                      //             onChanged: (newValue1) {
                      //               setState(() {
                      //                 stateValueChoose = newValue1;
                      //               });
                      //             },
                      //             onSaved: (newValue1) {
                      //               setState(() {
                      //                 stateValueChoose = newValue1;
                      //               });
                      //             },
                      //             items: statelList.map((valueItem1) {
                      //               return DropdownMenuItem(
                      //                 value: valueItem1,
                      //                 child: Text(valueItem1,
                      //                     style: TextStyle(fontSize: 16)),
                      //               );
                      //             }).toList(),
                      //           )),
                      //     ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Session Days',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  snapshot.data.docs.first
                                      .data()['session_day'],
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Session Times',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  snapshot.data.docs.first
                                      .data()['session_time'],
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey.shade300))),
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Row(children: [
                                  Text('Date', style: h4),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ])),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 170,
                                    child: DateTimeField(
                                      format: format,
                                      onShowPicker:
                                          (context, currentValue) async {
                                        return await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        );
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.date_range,
                                            color: accentYellow,
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              30.0, 15.0, 20.0, 15.0),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white60,
                                                  width: 15.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                      resetIcon: null,
                                      validator: textReviewValidation,
                                      initialValue: DateTimeField.tryParse(
                                          sesDate.text, format),
                                      onSaved: (val) {
                                        sessionDate = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                );
              }));
    }

    void _sendToServer() async {
      //  if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final action = await Dialogs.yesAbortDialog(context, 'Are you sure?',
          'are you sure you want to edit this session?');
      if (action == DialogAction.yes) {
        FirebaseFirestore.instance
            .collection('session')
            .where('sessionId', isEqualTo: this.id)
            .get()
            .then((value) => value.docs.forEach((element) {
                  element.reference.update({
                    'ses_name': '$sessionName',
                    'session_type': '$typeValueChoose',
                    'course_name': '$coursesValueChoose',
                    'ses_description': '$sessionDescription',
                    'ses_agenda': '$sessionAgenda',
                    'ses_location': '$locationValueChoose',
                    'ses_requirements': '$sesssionRequirements',
                    'academic_level': '$levelValueChoose',
                    'tutor_name': '$tutorName',
                    // 'state': '$stateValueChoose',
                    'ses_date':
                        '${formattedDate = DateFormat('dd-MM-yyyy').format(sessionDate)}',
                  }).then(
                    (value) => print('Success!'),
                  );
                }));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ManageSessionsPage(),
          ),
        );
      } else {
        setState(() => null);
      }
      //  }
    }

    final editButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentYellow,
      child: MaterialButton(
        height: 50,
        minWidth: 190,
        padding: EdgeInsets.fromLTRB(48.0, 0, 48.0, 0),
        disabledColor: Colors.grey,
        onPressed: () {
          _sendToServer();
        },
        child: Text("Edit",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );

    final deleteButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentOrange,
      child: MaterialButton(
        height: 50,
        minWidth: 190,
        padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
        disabledColor: Colors.grey,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            final action = await WarningDialogs.yesAbortDialog(context,
                'Warning', 'Are you sure you want to delete this session?');
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
                  builder: (context) => ManageSessionsPage(),
                ),
              );
            } else {
              setState(() => null);
            }
          }
        },
        child: Text("Delete",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );

    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Edit Session Details',
      ),
      endDrawer: Drawer(
        child: MainDrawer(),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          table(),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                editButton,
                SizedBox(
                  width: 20,
                ),
                deleteButton
              ],
            ),
          )
        ],
      )),
    );
  }
}
