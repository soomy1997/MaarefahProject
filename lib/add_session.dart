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

String valueChoose;
List listItems = ["College Courses", "Additional Skills Courses"];

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
        hintText: 'Sessuin Name', prefixIcon: Icon(Icons.person)));

String locationGroupValue = '';
bool isLocationSelected = false;

final _formKey = GlobalKey<FormState>();

class _AddSessionPage extends State<AddSessionPage> {
  Widget build(BuildContext context) {
    final requistButon = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xffF9A21B),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          disabledColor: Colors.grey,
          onPressed: isLocationSelected
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
                    });
                  },
                  items: listItems.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text('Type: ' + valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20.0,
                ),
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
                SizedBox(height: 15),
                sessionNameField,
                SizedBox(height: 15),
                DropdownButtonFormField(
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
          ),
        ),
      ),
    );
  }
}
