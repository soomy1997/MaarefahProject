import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/screen%20messages/tutor_add_session_congrats.dart';
import 'package:flutter_app_1/services/database.dart';
import '../utils/constants.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

class AddSessionPage extends StatefulWidget {
  AddSessionPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddSessionPage createState() => _AddSessionPage();
}

//from https://stackoverflow.com/questions/29628989/how-to-capitalize-the-first-letter-of-a-string-in-dart
extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}

bool visibilityValue = false;
String sessionName,
    valueChoose,
    sessionDescription,
    sessionAgenda,
    sessionRequirements;

final sessionNumController = TextEditingController();
final sessionNameController = TextEditingController();

num sessionNumber;

List sessionTypes = ["College Courses", "Additional Skills Courses"];
List levelsList = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];

String coursesValue;
List coursesList = [
  "Object Oriented Programming 1",
  "Discreate Math",
  "Operating Systems",
  "Busniess Management",
  "Human Computer Interaction",
];

String locationGroupValue = 'Online';
String daysGroupValue = 'Sunday';
String timeGroupValue = '8 PM';


bool buttonDisabled = false;

final _formKey = GlobalKey<FormState>();

class _AddSessionPage extends State<AddSessionPage> {
  // String imageUrl;
  String url;
  //generating random uuid
  String sessionId = Uuid().v4();

  //getting current user information
  OurUser _currentUser = OurUser();
  OurUser _cUser;
  OurUser get getCurrntUser => _currentUser;
  Future<void> getUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);
    setState(() {
      _cUser = _currentUser;
    });
  }

  final format = DateFormat("dd-MM-yyyy hh:mm a");
  DateTime selectedDate;
  // DateTime selectedDate = DateTime.now();
  // String formattedDate;
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  // final format = DateFormat("hh:mm a");
  // TimeOfDay selectedTime;
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay(hour: 7, minute: 15),
  //     initialEntryMode: TimePickerEntryMode.input,
  //   );
  //   if (picked != null && picked != selectedTime)
  //     setState(() {
  //       selectedTime = picked;
  //     });
  // }

  // TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  // void _selectTime(BuildContext context) async {
  //   final TimeOfDay newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _time = newTime;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Widget build(BuildContext context) {
    void _sendToServer() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        List<String> splitList = sessionName.split('');
        List<String> indexList = [];
        for (int i = 0; i < splitList.length; i++) {
          for (int y = 0; y < splitList[i].length + 1; y++) {
            indexList.add(splitList[i].substring(0, y).toLowerCase());
          }
        }
        FirebaseFirestore.instance
            .runTransaction((Transaction transaction) async {
          CollectionReference reference =
              FirebaseFirestore.instance.collection('session');
          await reference.add({
            'ses_name': sessionName.capitalizeFirstofEach,
            'ses_type': '$valueChoose',
            'sessionId': '$sessionId',
            'course_name': '$coursesValue',
            'ses_description': '$sessionDescription',
            'ses_location': '$locationGroupValue',
            'ses_requirement': '$sessionRequirements',
            'ses_agenda': '$sessionAgenda',
            'academic_level': '${_cUser.academicLevel}',
            'tutor_name': '${_cUser.name}',
            'tutor_PhoneNum': '${_cUser.phoneNum}',
            'tutor_email': '${_cUser.email}',
            'ses_period': sessionNumController.text,
            'session_day': '',
            'session_time': '',
            'image_url': '$url',
            'approved': 'no',
            'searchIndex': indexList,
            'avatar_url': '${_cUser.avatarUrl}',
            'uid': '${_cUser.uid}',
            'time_stamp': selectedDate,
          });
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AddSessionCongrats(),
          ),
          (route) => false,
        );
        _formKey.currentState.reset();
        sessionNameController.clear();
      } else {
        setState(() {
          return AutovalidateMode.disabled;
        });
      }
    }

    final requistButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xffF9A21B),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          //disabledColor: Colors.grey,
          onPressed:
              // isLocationSelected && isDaySelected && isTimeSelected
              //?
              () {
            _sendToServer();
          },
          // : null,
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
              children: <Widget>[
                SizedBox(height: 10.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Upload Session image",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  child: (url != null)
                      ? Image.network(
                          url,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return Center(child: CircularProgressIndicator());
                          },
                        )
                      : Placeholder(
                          fallbackHeight: 200,
                          fallbackWidth: double.infinity,
                        ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.upload_rounded,
                    ),
                    label: Text("upload image"),
                    style: ElevatedButton.styleFrom(
                      primary: accentYellow,
                    ),
                    onPressed: () => uploadImage(),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Session Name",
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: false,
                  style: h5,
                  controller: sessionNameController,
                  validator: nameValidation,
                  decoration: textInputDecoratuon.copyWith(
                    hintText: 'Session Name',
                  ),
                  onSaved: (value) {
                    sessionName = value;
                  },
                ),

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
                      child: Text(valueItem),
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
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
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
                    onSaved: (course) {
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
                  validator: textAreaValidation2,
                  decoration: textInputDecoratuon.copyWith(
                      hintText: "Enter your text here"),
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    sessionDescription = value;
                  },
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text(
                    "Session Agenda",
                    textAlign: TextAlign.left,
                    style: h4,
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  maxLines: 3,
                  style: h5,
                  validator: textAreaValidation,
                  decoration: textInputDecoratuon.copyWith(
                      hintText: "Enter your text here"),
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    sessionAgenda = value;
                  },
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
                                // isLocationSelected = true;
                              });
                            }),
                        Text('Physical'),
                        Radio(
                            autofocus: true,
                            value: 'Online',
                            groupValue: locationGroupValue,
                            activeColor: Colors.orange,
                            onChanged: (val) {
                              setState(() {
                                locationGroupValue = val;
                                // isLocationSelected = true;
                              });
                            }),
                        Text('Online'),
                      ]),
                ),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text(
                    "Session Requirements",
                    textAlign: TextAlign.left,
                    style: h4,
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  maxLines: 3,
                  style: h5,
                  validator: textAreaValidation,
                  decoration: textInputDecoratuon.copyWith(
                      hintText: "Enter your text here"),
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) {
                    sessionRequirements = value;
                  },
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text(
                    "Number of hours for the session",
                    textAlign: TextAlign.left,
                    style: h4,
                  ),
                ),
                SizedBox(height: 15.0),
                NumberInputWithIncrementDecrement(
                  controller: sessionNumController,
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
                    ),
                  ),
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
                  decIcon: Icons.keyboard_arrow_down,
                ),
                SizedBox(height: 15.0),
                // SizedBox(
                //   height: 20.0,
                //   width: double.infinity,
                //   child: Text(
                //     "Suitable Tutoring Day",
                //     textAlign: TextAlign.left,
                //     style: h4,
                //   ),
                // ),
                SizedBox(height: 15),
                // Container(
                //     alignment: Alignment.center,
                //     width: double.infinity,
                //     height: 200,
                //     child: SingleChildScrollView(
                //       child: Table(
                //           defaultVerticalAlignment:
                //               TableCellVerticalAlignment.middle,
                //           columnWidths: {
                //             0: FlexColumnWidth(5),
                //             1: FlexColumnWidth(7),
                //             2: FlexColumnWidth(5),
                //             3: FlexColumnWidth(7),
                //           },
                //           children: [
                //             TableRow(
                //               children: [
                //                 Radio(
                //                     autofocus: true,
                //                     value: 'Sunday',
                //                     groupValue: daysGroupValue,
                //                     activeColor: Colors.orange,
                //                     onChanged: (val) {
                //                       setState(() {
                //                         daysGroupValue = val;
                //                         // isDaySelected = true;
                //                       });
                //                     }),
                //                 Text('Sunday'),
                //                 Radio(
                //                     value: 'Monday',
                //                     groupValue: daysGroupValue,
                //                     activeColor: Colors.orange,
                //                     onChanged: (val) {
                //                       setState(() {
                //                         daysGroupValue = val;
                //                         // isDaySelected = true;
                //                       });
                //                     }),
                //                 Text('Monday'),
                //               ],
                //             ),
                //             TableRow(children: [
                //               Radio(
                //                   value: 'Tuesday',
                //                   groupValue: daysGroupValue,
                //                   activeColor: Colors.orange,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       daysGroupValue = val;
                //                       //isDaySelected = true;
                //                     });
                //                   }),
                //               Text('Tuesday'),
                //               Radio(
                //                   value: 'Wednesday',
                //                   groupValue: daysGroupValue,
                //                   activeColor: Colors.orange,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       daysGroupValue = val;
                //                       // isDaySelected = true;
                //                     });
                //                   }),
                //               Text('Wednesday'),
                //             ]),
                //             TableRow(children: [
                //               Radio(
                //                   value: 'Thursday',
                //                   groupValue: daysGroupValue,
                //                   activeColor: Colors.orange,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       daysGroupValue = val;
                //                       //isDaySelected = true;
                //                     });
                //                   }),
                //               Text('Thursday'),
                //               Radio(
                //                   value: 'Friday',
                //                   groupValue: daysGroupValue,
                //                   activeColor: Colors.orange,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       daysGroupValue = val;
                //                       //isDaySelected = true;
                //                     });
                //                   }),
                //               Text('Friday'),
                //             ]),
                //             TableRow(children: [
                //               Radio(
                //                   value: 'Saturday',
                //                   groupValue: daysGroupValue,
                //                   activeColor: Colors.orange,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       daysGroupValue = val;
                //                       // isDaySelected = true;
                //                     });
                //                   }),
                //               Text('Saturday'),
                //               Text(' '),
                //               Text(' '),
                //             ])
                //           ]),
                //     )),
                // SizedBox(height: 15),
                // SizedBox(
                //   height: 20.0,
                //   width: double.infinity,
                //   child: Text("Suitable time(s) for holding the session",
                //       textAlign: TextAlign.left, style: h4),
                // ),
                // SizedBox(height: 15.0),
                // Container(
                //     alignment: Alignment.center,
                //     width: double.infinity,
                //     height: 100,
                //     child: SingleChildScrollView(
                //       child: Table(
                //           defaultVerticalAlignment:
                //               TableCellVerticalAlignment.middle,
                //           columnWidths: {
                //             0: FlexColumnWidth(5),
                //             1: FlexColumnWidth(7),
                //             2: FlexColumnWidth(5),
                //             3: FlexColumnWidth(7),
                //           },
                //           children: [
                //             TableRow(
                //               children: [
                //                 Radio(
                //                     autofocus: true,
                //                     value: '6 PM',
                //                     groupValue: timeGroupValue,
                //                     activeColor: Colors.orange,
                //                     onChanged: (val) {
                //                       setState(() {
                //                         timeGroupValue = val;
                //                         // isTimeSelected = true;
                //                       });
                //                     }),
                //                 Text('6 PM'),
                //                 Radio(
                //                     value: '7 PM',
                //                     groupValue: timeGroupValue,
                //                     activeColor: Colors.orange,
                //                     onChanged: (val) {
                //                       setState(() {
                //                         timeGroupValue = val;
                //                         // isTimeSelected = true;
                //                       });
                //                     }),
                //                 Text('7 PM'),
                //               ],
                //             ),
                //             TableRow(children: [
                //               Radio(
                //                   value: '8 PM',
                //                   groupValue: timeGroupValue,
                //                   activeColor: Colors.orange,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       timeGroupValue = val;
                //                       // isTimeSelected = true;
                //                     });
                //                   }),
                //               Text('8 PM'),
                //               Radio(
                //                   value: '9 PM',
                //                   groupValue: timeGroupValue,
                //                   activeColor: Colors.orange,
                //                   onChanged: (val) {
                //                     setState(() {
                //                       timeGroupValue = val;
                //                       //isTimeSelected = true;
                //                     });
                //                   }),
                //               Text('9 PM'),
                //             ]),
                //           ]),
                //     )),
                //
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text('Session Date and Time',
                      textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: DateTimeField(
                    format: format,
                    validator: (date) => date == null ? 'Invalid date' : null,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.date_range,
                        color: accentYellow,
                        size: 30,
                      ),
                      hintText: 'Session Date and Time',
                      contentPadding:
                          EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white60, width: 15.0),
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    //initialValue: DateTime.now(),

                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100),);
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    onSaved: (dateTime) {
                      selectedDate = dateTime;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // SizedBox(
                //   height: 20.0,
                //   child: Row(
                //     children: [
                //       Text('${format.pattern}'),
                //       Text('${_time.format(context)}'),
                //       DateTimeField(
                //         format: format,
                //         onShowPicker: (context, currentValue) async {
                //           final TimeOfDay time = await showTimePicker(
                //             context: context,
                //             initialTime: TimeOfDay.fromDateTime(
                //                 currentValue ?? DateTime.now()),
                //           );
                //           return time == null
                //               ? null
                //               : DateTimeField.convert(time);
                //         },
                //       ),
                //       SizedBox(
                //         width: 50.0,
                //       ),
                //       MaterialButton(
                //         onPressed: () => _selectTime(context),
                //         child: Text(
                //           'Select time',
                //           style: TextStyle(color: accentYellow),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20.0,
                // ),
                // SizedBox(
                //   height: 20.0,
                //   width: double.infinity,
                //   child: Text(
                //     "Session Date",
                //     textAlign: TextAlign.left,
                //     style: h4,
                //   ),
                // ),
                // SizedBox(
                //   height: 20.0,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   height: 20.0,
                //   child: Row(
                //     children: [
                //       Text(
                //         "${formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate)}",
                //       ),
                //       SizedBox(
                //         width: 30.0,
                //       ),
                //       MaterialButton(
                //         onPressed: () => _selectDate(context),
                //         child: Text(
                //           'Select date',
                //           style: TextStyle(color: accentYellow),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: 20.0),
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

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    //check permission for accessing photos
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      String fileName = basename(file.path);
      if (image != null) {
        //Upload to firebase
        UploadTask uploadTask =
            _storage.ref().child('sessinImages/' + fileName).putFile(file);
        // = ref.putFile(file);
        var imageUrl = await (await uploadTask).ref.getDownloadURL();
        setState(() {
          url = imageUrl.toString();
        });
      } else {
        print('no path recieved');
      }
    } else {
      print('permission denied..Grant permission and try again');
    }
  }
}
