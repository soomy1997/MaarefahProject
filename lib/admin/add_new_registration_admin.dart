import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

import 'admin_compnent/custom_dialog_admin.dart';
import 'admin_compnent/main_drawer.dart';

class AddNewRegister extends StatefulWidget {
  AddNewRegister({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddNewRegisterState createState() => _AddNewRegisterState();
}

class _AddNewRegisterState extends State<AddNewRegister> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController pass2Controller = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();

  var password = "";
  var userName = "";
  var email = "";
  var option = "";
  var confirmPassword = "";
  var gray = Colors.grey;
  var red = Colors.red;
  var color = Colors.black;
  var textColor = Colors.black;
  final List<String> options = [
    "Introduction to OOP1",
    "MIntroduction to OOP2",
    "Introduction to Main"
  ];

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return "this field is required";
        }

        return null;
      },
      controller: passController,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.date_range_rounded,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "Date",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final userNameField = TextFormField(
      controller: pass2Controller,
      validator: (input) {
        userName = input;
        if (input.isEmpty) {
          return "this field is required";
        }

        return null;
      },
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.perm_identity,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "Learner Name",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final emailField = TextFormField(
      controller: emailContoller,
      validator: (input) {
        email = input;
        if (input.isEmpty) {
          return "this field is required";
        }

        return null;
      },
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.email,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "Learner Email",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final optionFild = DropdownButtonFormField(
      style: TextStyle(fontSize: 18),
      isDense: true,
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 22,
      ),
      iconEnabledColor: Theme.of(context).primaryColor,
      items: options.map((priority) {
        return DropdownMenuItem(
          value: priority,
          child: Text(
            priority,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.file_copy,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "current session",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
      validator: (input) => option == null ? "Please Select Option" : null,
      onChanged: (val) {
        setState(() {
          option = val;
        });
      },
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: _submit,
        child: Text("Add Now",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
      ),
    );

    return Scaffold(
      appBar: myAppBar2(
        context, 
        title: 'Add New Registration',
        ),
        endDrawer: Drawer(
          child: MainDrawer(),
        ),
      body: buildCenter(
          passwordField, loginButon, userNameField, emailField, optionFild),
    );
  }

  Widget buildCenter(
      TextFormField passwordField,
      Material loginButon,
      TextFormField userNameField,
      TextFormField emailFiled,
      DropdownButtonFormField optionFild) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Add New registration",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 30.0),
                  userNameField,
                  SizedBox(height: 30.0),
                  emailFiled,
                  SizedBox(height: 30.0),
                  optionFild,
                  SizedBox(height: 30.0),
                  passwordField,
                  SizedBox(
                    height: 20.0,
                  ),
                  loginButon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      // here code
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "You Successfully ",
              descriptions: "Added new Registration",
              text: "Yes",
            );
          });
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
