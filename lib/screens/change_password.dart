import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String phoneNo;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final passwordField = TextFormField(
      obscureText: false,
      validator: phoneValidaton,
      keyboardType: TextInputType.number,
      style: h5,
      decoration: textInputDecoratuon.copyWith(
          hintText: 'Password', prefixIcon: Icon(Icons.lock)),
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
        onPressed: () {},
        child: Text("Change Password",
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
                    child:
                        Text("Password", textAlign: TextAlign.left, style: h4),
                  ),
                  SizedBox(height: 15.0),
                  passwordField,
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("Password Confirmation",
                        textAlign: TextAlign.left, style: h4),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: true,
                    style: h5,
                    keyboardType: TextInputType.number,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
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
