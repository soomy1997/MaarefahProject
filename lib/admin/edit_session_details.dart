import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_1/utils/constants.dart';

class EditSessionDetailsPage extends StatefulWidget {
  final String id;
  EditSessionDetailsPage({@required this.id});

  @override
  _EditSessionDetailsPage createState() => _EditSessionDetailsPage(id: this.id);
}

class _EditSessionDetailsPage extends State<EditSessionDetailsPage> {
  final String id;
  _EditSessionDetailsPage({@required this.id});

  String locationGroupValue = '';
  bool isLocationSelected = false;
  String stateGroupValue = '';
  String sessionType = '';
  String levelValueChoose;
  String typeValueChoose;
  String coursesValueChoose;

  List coursesList = [
    "Object Oriented Programming 1",
    "Discreate Math",
    "Operating Systems"
  ];
  List levelList = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  List sessionTypes = ["College Courses", "Additional Skills Courses"];
  bool approvalstate = false;

  bool isStateSelected = false;

  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();

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
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                    width: 1.0, color: Colors.grey.shade300))),
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
                                    .data()["sessionName"],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
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
                                'Session Type',
                                style: h4,
                              )),
                          Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                hint: Text('Session Type'),
                                icon: Icon(Icons.arrow_drop_down),
                                style: h5,
                                isExpanded: true,
                                validator: (value) => value == null
                                    ? '   This field is required'
                                    : null,
                                value: typeValueChoose,
                                onChanged: (newValue) {
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
                                'Course Name',
                                style: h4,
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                            child:
                                typeValueChoose == 'Additional Skills Courses'
                                    ? TextFormField(
                                        obscureText: false,
                                        validator: nameValidation,
                                        initialValue: 'Lorem Ipsum',
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
                                        value: coursesValueChoose,
                                        onChanged: (course) {
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
                                    width: 1.0, color: Colors.grey.shade300))),
                        children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                'Session Discribtion',
                                style: h4,
                              )),
                          Container(
                              padding: EdgeInsets.all(15),
                              child: TextFormField(
                                obscureText: false,
                                validator: nameValidation,
                                initialValue: 'Lorem Ipsum',
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
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
                                'Agenda',
                                style: h4,
                              )),
                          Container(
                              padding: EdgeInsets.all(15),
                              child: TextFormField(
                                obscureText: false,
                                validator: nameValidation,
                                initialValue: 'Lorem Ipsum',
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
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
                                'Location',
                                style: h4,
                              )),
                          Container(
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            height: 55,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                      value: 'Physical',
                                      groupValue: locationGroupValue,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          locationGroupValue = val;
                                          isLocationSelected = true;
                                        });
                                      }),
                                  Text('Physical'),
                                  Radio(
                                      value: 'Online',
                                      groupValue: locationGroupValue,
                                      activeColor: Colors.orange,
                                      onChanged: (val) {
                                        setState(() {
                                          locationGroupValue = val;
                                          isLocationSelected = true;
                                        });
                                      }),
                                  Text('Online'),
                                ]),
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
                                'Requirements',
                                style: h4,
                              )),
                          Container(
                              padding: EdgeInsets.all(15),
                              child: TextFormField(
                                obscureText: false,
                                validator: nameValidation,
                                initialValue: 'Lorem Ipsum',
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
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
                                value: levelValueChoose,
                                onChanged: (newValue1) {
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
                                    width: 1.0, color: Colors.grey.shade300))),
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
                                initialValue: 'Lorem Ipsum',
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                ),
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
                              ])),
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
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
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
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
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
                              ])),
                          Container(
                            padding: EdgeInsets.all(10),
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
              }));
    }

    final editButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentYellow,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(48.0, 0, 48.0, 0),
        disabledColor: Colors.grey,
        onPressed: isLocationSelected && isStateSelected ? () {} : null,
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
        onPressed: () {},
        child: Text("Delete",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );

    return Scaffold(
      appBar: myAppBar1(
        context,
        title: 'Edit Session Details',
        iconButton: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 40,
          onPressed: () => (0),
        ),
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
