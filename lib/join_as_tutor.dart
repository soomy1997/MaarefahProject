import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/screen%20messages/join_as_tutor_congrats.dart';
import 'package:flutter_app_1/services/database.dart';
import 'utils/constants.dart';

class JoinTutorPage extends StatefulWidget {
  JoinTutorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _JoinTutorPage createState() => _JoinTutorPage();
}

class _JoinTutorPage extends State<JoinTutorPage> {
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

  @override
  void initState() {
    super.initState();
    getUserInfo();
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
          'name': '${_cUser.lName}',
          'academicLevel': '${_cUser.lAcademicLevel}',
          'email': '${_cUser.lEmail}',
          'uid': '${_cUser.uid}',
          'phoneNo': '$phoneNo',
          'gender': '${_cUser.lGender}',
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

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String valueChoose;
  List listItems = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  String genderGroupValue = '';

  String phoneNo, teachingOverview;

  bool buttonDisabled = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  phoneField,
                  SizedBox(
                    height: 15.0,
                  ),
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
    );
  }
}
