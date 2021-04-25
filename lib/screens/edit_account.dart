import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/admin_compnent/dialogs.dart';
import 'package:flutter_app_1/screens/profile.dart';
import 'package:flutter_app_1/models/users.dart';
import 'package:flutter_app_1/services/database.dart';
import '../utils/constants.dart';

class EditAccountPage extends StatefulWidget {
  @override
  _EditAccountPage createState() => _EditAccountPage();
}

class _EditAccountPage extends State<EditAccountPage> {
  OurUser _currentUser = OurUser();
  OurUser _cUser = OurUser();

  Future<void> currentUserInfo() async {
    User _firebaseUser = FirebaseAuth.instance.currentUser;
    _currentUser = await OurDatabase().getuserInfo(_firebaseUser.uid);

    setState(() {
      _cUser = _currentUser;
    });
  }

  @override
  void initState() {
    super.initState();
    currentUserInfo();
  }

  String newName;
  String newEmail;
  String newLevel;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String valueChoose;

  List listItems = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  String genderGroupValue;

  bool isGenderSelected = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameFeild = TextFormField(
        validator: nameValidation,
        initialValue: _cUser.name,
        onChanged: (val) => setState(() => newName = val),
        obscureText: false,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            //hintText: 'or old name if you dont want it to change',
            prefixIcon: Icon(Icons.person)));
    final emailField = TextFormField(
        validator: emailValidation,
        initialValue: _cUser.email,
        onChanged: (val) => setState(() => newEmail = val),
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            //hintText: 'Email',
            prefixIcon: Icon(Icons.email)));

    final submitButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          disabledColor: Colors.grey,
          child: Text("Confirm Changes",
              textAlign: TextAlign.center, style: yellowButtonsTextStyle),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              final action = await Dialogs.yesAbortDialog(context, 'Sure?',
                  'Are you sure you want to change your account informaion?');
              if (action == DialogAction.yes) {
                FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: _cUser.uid)
                    .get()
                    .then((value) => value.docs.forEach((element) {
                          element.reference.update({
                            'name': '$newName',
                            'email': '$newEmail',
                            'academicLevel': '$newLevel',
                          });
                        }));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              } else {
                setState(() => null);
              }
            }
          }),
    );
//arrow_back_ios

    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Edit Account ',
      ),
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
                Text(_cUser.name, style: TextStyle(color: Colors.white)),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("New Name", textAlign: TextAlign.left, style: h4),
                ),
                nameFeild,
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child:
                      Text("New Email", textAlign: TextAlign.left, style: h4),
                ),
                emailField,
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("New Academic Level",
                      textAlign: TextAlign.left, style: h4),
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)))),
                  hint: Text('Academic Level'),
                  icon: Icon(Icons.arrow_drop_down),
                  style: h5,
                  isExpanded: true,
                  autofocus: false,
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      newLevel = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'This field is required.' : null,
                  items: listItems.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text('Academic Level: ' + valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15),
                submitButon,
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
