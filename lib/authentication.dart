import 'package:flutter/material.dart';
import 'home_page.dart';
import 'utils/constants.dart';
import 'net/flutterfire.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          bool shouldNavigate =
              await signIn(_emailField.text, _passwordField.text);
          if (shouldNavigate) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        },
        child: Text("Get started",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                  child: Text("Welcome Back :)",
                      textAlign: TextAlign.center, style: h1),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (50.0 / 812),
                  child: Text(
                      "Enter your email and password for signing in. Thanks ",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    obscureText: false,
                    controller: _emailField,
                    style: h5,
                    decoration: textInputDecoratuon.copyWith(
                      hintText: 'example@gmail.com',
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      labelStyle: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                      obscureText: true,
                      controller: _passwordField,
                      style: h5,
                      decoration: textInputDecoratuon.copyWith(
                        hintText: '******',
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        labelStyle: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      )),
                ),
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 35.0,
                  child: Text("Forgot password? Reset here.",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 35.0,
                  child: Text("No account? Create one.",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
