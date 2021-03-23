import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

void main() {
  runApp(AddSession());
}

class AddSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add Session',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AddSessionPage(title: 'Add Session'),
    );
  }
}

class AddSessionPage extends StatefulWidget {
  AddSessionPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddSessionPage createState() => _AddSessionPage();
}

bool visibilityValue = false;
String valueChoose;
List sessionTypes = ["College Courses", "Additional Skills Courses"];
List levelsList = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];

String coursesValue;
List coursesList = [
  "Object Oriented Programming 1",
  "Discreate Math",
  "Operating Systems"
];

final sessionNameField = TextFormField(
    obscureText: false,
    style: h5,
    validator: nameValidation,
    decoration: textInputDecoratuon.copyWith(
      hintText: 'Session Name',
    ));

String locationGroupValue = '';
String daysGroupValue = '';
String timeGroupValue = '';

bool isLocationSelected = false;
bool isDaySelected = false;
bool isTimeSelected = false;

bool buttonDisabled = false;

final _formKey = GlobalKey<FormState>();

class _AddSessionPage extends State<AddSessionPage> {
  Widget build(BuildContext context) {
    final requistButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xffF9A21B),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          disabledColor: Colors.grey,
          onPressed: isLocationSelected && isDaySelected && isTimeSelected
              ? () {
                  _formKey.currentState.validate();
                }
              : null,
          child: Text("Add Now",
              textAlign: TextAlign.center, style: yellowButtonsTextStyle),
        ));

    return Scaffold(
      appBar: myAppBar2(context, title: 'Add Session'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(36),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Session Name",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(
                  height: 20.0,
                ),
                sessionNameField,
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Session Type",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(
                  height: 15.0,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)))),
                  hint: Text('Session Type'),
                  icon: Icon(Icons.arrow_drop_down),
                  style: h5,
                  isExpanded: true,
                  validator: (value) =>
                      value == null ? '   This field is required' : null,
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue;
                      newValue == 'College Courses'
                          ? visibilityValue = true
                          : visibilityValue = false;
                    });
                  },
                  items: sessionTypes.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text('Type: ' + valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: visibilityValue,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                    hint: Text('Course Name'),
                    icon: Icon(Icons.arrow_drop_down),
                    style: h5,
                    isExpanded: true,
                    validator: (value) =>
                        value == null ? '   This field is required' : null,
                    value: coursesValue,
                    onChanged: (course) {
                      setState(() {
                        coursesValue = course;
                      });
                    },
                    items: coursesList.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text('Course: ' + valueItem),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Session Description",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  maxLines: 3,
                  style: h5,
                  validator: textAreaValidation,
                  decoration: textInputDecoratuon.copyWith(
                      hintText: "Enter your text here"),
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Session Agenda",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  maxLines: 3,
                  style: h5,
                  validator: textAreaValidation,
                  decoration: textInputDecoratuon.copyWith(
                      hintText: "Enter your text here"),
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Session Location",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15),
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
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Session Requirements",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  maxLines: 3,
                  style: h5,
                  validator: textAreaValidation,
                  decoration: textInputDecoratuon.copyWith(
                      hintText: "Enter your text here"),
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Level", textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)))),
                  hint: Text('Academic Level'),
                  icon: Icon(Icons.arrow_drop_down),
                  style: h5,
                  isExpanded: true,
                  validator: (value) =>
                      value == null ? '   This field is required' : null,
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue;
                    });
                  },
                  items: levelsList.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text('Academic Level: ' + valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child:
                      Text("Tutor Name", textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  maxLines: 1,
                  style: h5,
                  validator: textAreaValidation,
                  decoration: textInputDecoratuon.copyWith(
                      hintText: "Enter your text here"),
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 15),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Number of hours for the session",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15.0),
                NumberInputWithIncrementDecrement(
                    controller: TextEditingController(),
                    min: 1,
                    max: 10,
                    numberFieldDecoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    widgetContainerDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    incIconDecoration: BoxDecoration(
                      color: accentYellow,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    separateIcons: true,
                    decIconDecoration: BoxDecoration(
                      color: accentYellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    incIconSize: 28,
                    decIconSize: 28,
                    incIcon: Icons.keyboard_arrow_up,
                    decIcon: Icons.keyboard_arrow_down),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text(
                    "Suitable Tutoring Days",
                    textAlign: TextAlign.left,
                    style: h4,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    child: SingleChildScrollView(
                      child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FlexColumnWidth(5),
                            1: FlexColumnWidth(7),
                            2: FlexColumnWidth(5),
                            3: FlexColumnWidth(7),
                          },
                          children: [
                            TableRow(
                              children: [
                                Radio(
                                    value: 'Sunday',
                                    groupValue: daysGroupValue,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setState(() {
                                        daysGroupValue = val;
                                        isDaySelected = true;
                                      });
                                    }),
                                Text('Sunday'),
                                Radio(
                                    value: 'Monday',
                                    groupValue: daysGroupValue,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setState(() {
                                        daysGroupValue = val;
                                        isDaySelected = true;
                                      });
                                    }),
                                Text('Monday'),
                              ],
                            ),
                            TableRow(children: [
                              Radio(
                                  value: 'Tuesday',
                                  groupValue: daysGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      daysGroupValue = val;
                                      isDaySelected = true;
                                    });
                                  }),
                              Text('Tuesday'),
                              Radio(
                                  value: 'Wednesday',
                                  groupValue: daysGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      daysGroupValue = val;
                                      isDaySelected = true;
                                    });
                                  }),
                              Text('Wednesday'),
                            ]),
                            TableRow(children: [
                              Radio(
                                  value: 'Thursday',
                                  groupValue: daysGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      daysGroupValue = val;
                                      isDaySelected = true;
                                    });
                                  }),
                              Text('Thursday'),
                              Radio(
                                  value: 'Friday',
                                  groupValue: daysGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      daysGroupValue = val;
                                      isDaySelected = true;
                                    });
                                  }),
                              Text('Friday'),
                            ]),
                            TableRow(children: [
                              Radio(
                                  value: 'Saturday',
                                  groupValue: daysGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      daysGroupValue = val;
                                      isDaySelected = true;
                                    });
                                  }),
                              Text('Saturday'),
                              Text(' '),
                              Text(' '),
                            ])
                          ]),
                    )),
                SizedBox(height: 15),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Suitable time(s) for holding the session",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15.0),
                Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 100,
                    child: SingleChildScrollView(
                      child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FlexColumnWidth(5),
                            1: FlexColumnWidth(7),
                            2: FlexColumnWidth(5),
                            3: FlexColumnWidth(7),
                          },
                          children: [
                            TableRow(
                              children: [
                                Radio(
                                    value: '6 PM',
                                    groupValue: timeGroupValue,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setState(() {
                                        timeGroupValue = val;
                                        isTimeSelected = true;
                                      });
                                    }),
                                Text('6 PM'),
                                Radio(
                                    value: '7 PM',
                                    groupValue: timeGroupValue,
                                    activeColor: Colors.orange,
                                    onChanged: (val) {
                                      setState(() {
                                        timeGroupValue = val;
                                        isTimeSelected = true;
                                      });
                                    }),
                                Text('7 PM'),
                              ],
                            ),
                            TableRow(children: [
                              Radio(
                                  value: '8 PM',
                                  groupValue: timeGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      timeGroupValue = val;
                                      isTimeSelected = true;
                                    });
                                  }),
                              Text('8 PM'),
                              Radio(
                                  value: '9 PM',
                                  groupValue: timeGroupValue,
                                  activeColor: Colors.orange,
                                  onChanged: (val) {
                                    setState(() {
                                      timeGroupValue = val;
                                      isTimeSelected = true;
                                    });
                                  }),
                              Text('9 PM'),
                            ]),
                          ]),
                    )),
                SizedBox(height: 35.0),
                requistButton,
                SizedBox(
                  height: 35.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
