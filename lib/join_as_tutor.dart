import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/screen%20messages/join_as_tutor_congrats.dart';
import 'utils/constants.dart';

class JoinTutorPage extends StatefulWidget {
  JoinTutorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _JoinTutorPage createState() => _JoinTutorPage();
}

class _JoinTutorPage extends State<JoinTutorPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String valueChoose;
  List listItems = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  String genderGroupValue = '';

  String name, phoneNo, teachingOverview;
  //checkboxes
  bool isGenderSelected = false;
  bool isDaySelected = false;
  bool isTimeSelected = false;
  bool buttonDisabled = false;

  // Map<String, bool> suitableTutoringDays = {
  //   'Sunday': false,
  //   'Monday': false,
  //   'Tuesday': false,
  //   'Wednsday': false,
  //   'Thursday': false,
  //   'Friday': false,
  //   'Saturday': false,
  // };
  // var tmpArray = [];

  // getCheckboxItems() {
  //   suitableTutoringDays.forEach((key, value) {
  //     if (value == true) {
  //       tmpArray.add(key);
  //     }
  //   });
  //   // Printing all selected items on Terminal screen.
  //   print(tmpArray);
  //   // Here you will get all your selected Checkbox items.

  //   // Clear array after use.
  //   tmpArray.clear();
  // }

  // Map<String, bool> suitableTimes = {
  //   '6 PM': false,
  //   '7 PM': false,
  //   '8 PM': false,
  //   '9 PM': false,
  // };

  // var timeArray = [];

  // getCheckboxTimeItems() {
  //   suitableTimes.forEach((key, value) {
  //     if (value == true) {
  //       timeArray.add(key);
  //     }
  //   });
  //   // Printing all selected items on Terminal screen.
  //   print(timeArray);
  //   // Here you will get all your selected Checkbox items.

  //   // Clear array after use.
  //   timeArray.clear();
  // }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameFeild = TextFormField(
      obscureText: false,
      style: h5,
      validator: nameValidation,
      decoration: textInputDecoratuon.copyWith(
          hintText: 'Full Name', prefixIcon: Icon(Icons.person)),
      onSaved: (value) {
        name = value;
      },
    );
    final phoneField = TextFormField(
      obscureText: false,
      validator: phoneValidaton,
      keyboardType: TextInputType.number,
      style: h5,
      decoration: textInputDecoratuon.copyWith(
          hintText: 'Phone Number',
          prefixIcon: Icon(Icons.phone_android_outlined)),
      onSaved: (value) {
        phoneNo = value;
      },
    );
    final requistButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        disabledColor: Colors.grey,
        onPressed: _sendToServer,
        child: Text("Request",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      appBar: myAppBar2(context, title: 'Request to Join as a Tutor'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20.0,
                              spreadRadius: 0.5,
                              offset: Offset(1.0, 1.0)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    nameFeild,
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
                      onSaved: (newValue) {
                        valueChoose = newValue;
                      },
                      items: listItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text('Academic Level: ' + valueItem),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 15.0),
                    phoneField,
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 20.0,
                      width: double.infinity,
                      child:
                          Text("Gender", textAlign: TextAlign.left, style: h4),
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
                              value: 'Male',
                              groupValue: genderGroupValue,
                              activeColor: Colors.orange,
                              onChanged: (val) {
                                setState(() {
                                  genderGroupValue = val;
                                  isGenderSelected = true;
                                });
                              },
                            ),
                            Text('Male'),
                            Radio(
                                value: 'Female',
                                groupValue: genderGroupValue,
                                activeColor: Colors.orange,
                                onChanged: (val) {
                                  setState(() {
                                    genderGroupValue = val;
                                    isGenderSelected = true;
                                  });
                                }),
                            Text('Female'),
                          ]),
                    ),
                    // SizedBox(height: 15),
                    // SizedBox(
                    //   height: 20.0,
                    //   width: double.infinity,
                    //   child: Text("Suitable Day(s) for holding the session",
                    //       textAlign: TextAlign.left, style: h4),
                    // ),
                    // SizedBox(
                    //   height: 400,
                    //   child: ListView(
                    //     children: suitableTutoringDays.keys.map((String key) {
                    //       return new CheckboxListTile(
                    //         title: new Text(key),
                    //         value: suitableTutoringDays[key],
                    //         activeColor: Colors.orange,
                    //         onChanged: (bool value) {
                    //           setState(() {
                    //             suitableTutoringDays[key] = value;
                    //             isDaySelected = true;
                    //           });
                    //         },
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    // SizedBox(height: 15.0),
                    // SizedBox(
                    //   height: 20.0,
                    //   width: double.infinity,
                    //   child: Text("Suitable time(s) for holding the session",
                    //       textAlign: TextAlign.left, style: h4),
                    // ),
                    // SizedBox(
                    //   height: 210,
                    //   child: ListView(
                    //     children: suitableTimes.keys.map((String key) {
                    //       return new CheckboxListTile(
                    //         title: new Text(key),
                    //         value: suitableTimes[key],
                    //         activeColor: Colors.orange,
                    //         onChanged: (bool value) {
                    //           setState(() {
                    //             suitableTimes[key] = value;
                    //             isTimeSelected = true;
                    //           });
                    //         },
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    SizedBox(height: 15.0),
                    SizedBox(
                      height: 20.0,
                      width: double.infinity,
                      child: Text("Overview of your teaching method",
                          textAlign: TextAlign.left, style: h4),
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      maxLines: 9,
                      style: h5,
                      validator: textAreaValidation,
                      decoration: textInputDecoratuon.copyWith(
                          hintText: "Enter your text here"),
                      keyboardType: TextInputType.multiline,
                      onSaved: (value) {
                        teachingOverview = value;
                      },
                    ),
                    SizedBox(height: 35.0),
                    requistButon,
                    SizedBox(
                      height: 35.0,
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void _sendToServer() {
    if (_formKey.currentState.validate()) {
      //No error in validator
      _formKey.currentState.save();
      FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        CollectionReference reference =
            FirebaseFirestore.instance.collection('tutoring_request');
        await reference.add({
          'name': '$name',
          'academicLevel': '$valueChoose',
          'phoneNo': '$phoneNo',
          'gender': '$genderGroupValue',
          'teachingOverview': '$teachingOverview'
        });
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Congrats(),
        ),
      );
    } else {
      setState(() {
        return AutovalidateMode.disabled;
      });
    }
  }
}
