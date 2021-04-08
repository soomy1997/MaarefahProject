import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  String locationValueChoose,
      stateValueChoose,
      sessionTypeValueChoose,
      levelValueChoose,
      typeValueChoose,
      coursesValueChoose,
      sessionName,
      sessionDescription,
      sessionAgenda,
      sesssionRequirements,
      tutorName,
      sessionDate;

  List coursesList = [
    'CS321 Object Oriented Programming 1',
    'MATH 311: Discrete Math',
    'CS532: Database Design',
    'Operating Systems',
    'Java Programming: 2 Books in 1'
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
                DateTime selectedDate;
                Future<void> _selectDate(BuildContext context) async {
                  final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate = DateTime.parse(sesDate.text),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                      sesDate.text = selectedDate.toLocal().toString();
                    });
                }

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
                                    .data()["sessionId"])),
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
                                  validator: nameValidation,
                                  initialValue: snapshot.data.docs.first
                                      .data()["ses_name"],
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
                                      //validator: nameValidation,
                                      initialValue: 'null',
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
                                  validator: nameValidation,
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
                                  validator: nameValidation,
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
                                  validator: nameValidation,
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
                                  validator: nameValidation,
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
                                  Text('State', style: h4),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ])),
                            Container(
                                padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                                child: DropdownButtonFormField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  hint: Text('State'),
                                  icon: Icon(Icons.arrow_drop_down),
                                  style: h5,
                                  isExpanded: true,
                                  validator: (value) => value == null
                                      ? '   This field is required'
                                      : null,
                                  value:
                                      snapshot.data.docs.first.data()['state'],
                                  onChanged: (newValue1) {
                                    setState(() {
                                      stateValueChoose = newValue1;
                                    });
                                  },
                                  onSaved: (newValue1) {
                                    setState(() {
                                      stateValueChoose = newValue1;
                                    });
                                  },
                                  items: statelList.map((valueItem1) {
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
                                  'Session Days',
                                  style: h4,
                                )),
                            Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  snapshot.data.docs.first
                                      .data()['sesssion_day'],
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
                              // width: 30,
                              padding: EdgeInsets.all(20),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
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
                                      initialValue:
                                          DateTime.parse(sesDate.text),
                                      onSaved: (val) {
                                        sessionDate = val.toString();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
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
                      // TableRow(
                      //     decoration: BoxDecoration(
                      //         border: Border(
                      //             bottom: BorderSide(
                      //                 width: 1.0, color: Colors.grey.shade300))),
                      //     children: [
                      //       Container(
                      //           padding: EdgeInsets.all(15),
                      //           child: Text(
                      //             'Attachements',
                      //             style: h4,
                      //           )),
                      //       Container(
                      //           padding: EdgeInsets.all(15),
                      //           child: Text(
                      //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                      //           )),
                      //     ]),
                    ],
                  ),
                );
              }));
    }

    final editButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentYellow,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(48.0, 0, 48.0, 0),
        disabledColor: Colors.grey,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            FirebaseFirestore.instance
                .collection('session')
                .where('sessionId', isEqualTo: this.id)
                .get()
                .then((value) => value.docs.forEach((element) {
                      element.reference.update({
                        'sessionName': '$sessionName',
                        'session_type': '$typeValueChoose',
                        'course_name': '$coursesValueChoose',
                        'session_description': '$sessionDescription',
                        'session_agenda': '$sessionAgenda',
                        'session_location': '$locationValueChoose',
                        'session_requirements': '$sesssionRequirements',
                        'academic_level': '$levelValueChoose',
                        'tutorName': '$tutorName',
                        'state': '$stateValueChoose',
                        'ses_date': '$sessionDate',
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
          }
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
        padding: EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
        disabledColor: Colors.grey,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
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
