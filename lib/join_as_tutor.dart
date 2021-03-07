import 'package:flutter/material.dart';
import 'utils/constants.dart';

void main() {
  runApp(JoinTutor());
}

class JoinTutor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Join Us as a Tutor',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: JoinTutorPage(title: 'Join Us as a Tutor'),
    );
  }
}

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
  //checkboxes

  bool isGenderSelected = false;
  bool isDaySelected = false;
  bool isTimeSelected = false;

  bool buttonDisabled = false;

  bool _sunChecked = false;
  bool _monChecked = false;
  bool _tueChecked = false;
  bool _wedChecked = false;
  bool _thuChecked = false;
  bool _friChecked = false;
  bool _satChecked = false;

  bool _sixChecked = false;
  bool _sevenChecked = false;
  bool _eightChecked = false;
  bool _nineChecked = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameFeild = TextFormField(
        obscureText: false,
        style: h5,
        validator: nameValidation,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Full Name', prefixIcon: Icon(Icons.person)));
    final phoneField = TextFormField(
        obscureText: false,
        validator: phoneValidaton,
        keyboardType: TextInputType.number,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_android_outlined)));
    final requistButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        disabledColor: Colors.grey,
        onPressed: isDaySelected && isGenderSelected && isTimeSelected
            ? () {
                _formKey.currentState.validate();
              }
            : null,
        child: Text("Request",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
//arrow_back_ios
    return Scaffold(
      appBar: myAppBar2(context, title: 'Request to Join as a Tutor'),
      body: SingleChildScrollView(
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
                    child: Text("Gender", textAlign: TextAlign.left, style: h4),
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
                              }),
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
                  SizedBox(height: 15),
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
                  new CheckboxListTile(
                      title: Text("Sunday"),
                      value: _sunChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _sunChecked = value;
                          isDaySelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("Monday"),
                      value: _monChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _monChecked = value;
                          isDaySelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("Tuesday"),
                      value: _tueChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _tueChecked = value;
                          isDaySelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("Wednesday"),
                      value: _wedChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _wedChecked = value;
                          isDaySelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("Thursday"),
                      value: _thuChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _thuChecked = value;
                          isDaySelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("Friday"),
                      value: _friChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _friChecked = value;
                          isDaySelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("Saturday"),
                      value: _satChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _satChecked = value;
                          isDaySelected = true;
                        });
                      }),
                  SizedBox(height: 15.0),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("Suitable time(s) for holding the session",
                        textAlign: TextAlign.left, style: h4),
                  ),
                  SizedBox(height: 15.0),
                  new CheckboxListTile(
                      title: Text("6 PM"),
                      value: _sixChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _sixChecked = value;
                          isTimeSelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("7 PM"),
                      value: _sevenChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _sevenChecked = value;
                          isTimeSelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("8 PM"),
                      value: _eightChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _eightChecked = value;
                          isTimeSelected = true;
                        });
                      }),
                  new CheckboxListTile(
                      title: Text("9 PM"),
                      value: _nineChecked,
                      activeColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          _nineChecked = value;
                          isTimeSelected = true;
                        });
                      }),
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
    );
  }
}
