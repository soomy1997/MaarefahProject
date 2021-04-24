import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/services/locator.dart';
import 'package:flutter_app_1/services/user_controller.dart';
import 'package:flutter_app_1/utils/constants.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String newPassword;
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool checkCurrentPassValid = true;
  void changePassword(String newPassword) async {
    //Create an instance of the current user.
    User user = await FirebaseAuth.instance.currentUser;
    //Pass in the password to updatePassword.
    user.updatePassword('newPassword').then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  Widget build(BuildContext context) {
    final requistButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        disabledColor: Colors.grey,
        onPressed: () async {
          UserController userController = locator.get<UserController>();
          changePassword(newPassword);

          checkCurrentPassValid = await userController.validateCurrentPassword(
            _passwordController.text,
          );
          // setState(() {});

          if (_formKey.currentState.validate()) {
            Navigator.pop(context);
          }
        },
        child: Text("Save Changes",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      appBar: myAppBar2(context, title: 'Change Password'),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("Current Password",
                        textAlign: TextAlign.left, style: h4),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: false,
                    validator: passwordValidation,
                    style: h5,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: '*******',
                      prefixIcon: Icon(Icons.lock),
                      errorText: checkCurrentPassValid
                          ? null
                          : "Please double check your Current Password",
                    ),
                    controller: _passwordController,
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("New Password",
                        textAlign: TextAlign.left, style: h4),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: true,
                    style: h5,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: '*******',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    controller: _newPasswordController,
                    onChanged: (pass) {
                      newPassword = pass;
                    },
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("Confirm Password",
                        textAlign: TextAlign.left, style: h4),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: true,
                    style: h5,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: '*******',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    controller: _confirmPasswordController,
                    validator: (input) {
                      if (input.isEmpty) {
                        return "This field is required";
                      }
                      if (_newPasswordController.text != input) {
                        return "The Pasword and it's confirmation do not match";
                      }
                      return null;
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
