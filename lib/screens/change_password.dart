import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _togglePasswordStatus1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _togglePasswordStatus2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  FToast fToast;
  void _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Successfully changed password"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  String newPassword;
  String currentPass;
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool checkCurrentPassValid = true;
  void changePassword(String newPassword) async {
    //Create an instance of the current user.
    User user = await FirebaseAuth.instance.currentUser;
    //Pass in the password to updatePassword.
    user.updatePassword(newPassword).then((_) {
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
          CurrentUser auth = Provider.of<CurrentUser>(context, listen: false);
          checkCurrentPassValid = await auth.validateCurrentPassword(
            _passwordController.text,
          );
          if (_formKey.currentState.validate() && checkCurrentPassValid) {
            changePassword(newPassword);
            _showToast();
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
                    obscureText: _obscureText,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "This field is required";
                      }
                      if (checkCurrentPassValid == false) {
                        return "Please double check your current password";
                      }
                      return null;
                    },
                    style: h5,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: '*******',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordStatus,
                      ),
                    ),
                    controller: _passwordController,
                    onSaved: (val) {
                      currentPass = val;
                    },
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
                    obscureText: _obscureText1,
                    style: h5,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: '*******',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText1
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordStatus1,
                      ),
                    ),
                    validator: (input) {
                      if (input.isEmpty) {
                        return "This field is required";
                      }
                      if (_passwordController.text == input) {
                        return "Current password and new password are same";
                      }
                      if (input.length < 7) {
                        return "Password must be at least 7 character";
                      }
                      if (!validateStructure(input)) {
                        return "uppercase, lowercase letters & numbers required";
                      }
                      return null;
                    },
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
                    obscureText: _obscureText2,
                    style: h5,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: '*******',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordStatus2,
                      ),
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

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
