import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/screens/send_email.dart';
import 'package:flutter_app_1/screens/sign_up_page.dart';
import 'package:flutter_app_1/utils/tabbed_app.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../services/flutterfire.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _loginUser(String email, String password, BuildContext context) async {
      CurrentUser _currentUser =
          Provider.of<CurrentUser>(context, listen: false);
      try {
        String _returnString = await _currentUser.loginUser(email, password);

        if (_returnString == 'success') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => TabbedApp(),
            ),
            (route) => false,
          );
        } else {
          // _showToast();
          Fluttertoast.showToast(
            msg: "Icorrect email or Password",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        print(e);
      }
    }

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _loginUser(_emailField.text, _passwordField.text, context);
          }
        },
        child: Text("Sign In", style: yellowButtonsTextStyle),
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
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    height: 170.0,
                    width: 150,
                    image: AssetImage("images/logos.png"),
                  ),
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          validator: emailValidation,
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
                          validator: passwordValidation,
                          obscureText: _obscureText,
                          controller: _passwordField,
                          style: h5,
                          decoration: textInputDecoratuon.copyWith(
                            hintText: '*******',
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            labelStyle: style.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: _togglePasswordStatus,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      loginButon,
                      SizedBox(
                        height: 80.0,
                      ),
                      SizedBox(
                        height: 35,
                        child: RichText(
                          text: TextSpan(
                              text: 'No account?',
                              style: style.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Sign Up.',
                                  style: style.copyWith(
                                      color: accentYellow, fontSize: 15),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpPage(),
                                        ),
                                      );
                                    },
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 35,
                        child: RichText(
                          text: TextSpan(
                              text: 'Forget Password?',
                              style: style.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Reset here',
                                  style: style.copyWith(
                                      color: accentYellow, fontSize: 15),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SendEmailPage(),
                                        ),
                                      );
                                    },
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
