import 'package:flutter/material.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/screens/sign_in_page.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  var password = "";
  var confirmPassword = "";
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String valueChoose;
  List listItems = ["3th", "4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  String genderGroupValue = '';
  String name, email, pass;
  //checkboxes
  bool isGenderSelected = false;
  bool buttonDisabled = false;

  final _formKey = GlobalKey<FormState>();

  void _signUpUser(String email, String password, BuildContext context,
      String lAcademicLevel, String lName, String lGender) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString = await _currentUser.signUpLearner(
          email, password, lAcademicLevel, lName, lGender);
      if (_returnString == 'success') {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this.confirmPassController.dispose();
    this.passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      obscureText: true,
      validator: (input) {
        if (input.isEmpty) {
          return "this field is required";
        }
        // if (input.length < 7) {
        //   return "The Password must be at least 7 character";
        // }
        if (input != passController.text) {
          return "The Password and its confirmation do not match";
        }
        return null;
      },
      controller: confirmPassController,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: kTextLightColor,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: 'Confirm Password',
          border: OutlineInputBorder(
              borderSide: BorderSide(color: kTextLightColor, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final passwordField2 = TextFormField(
      obscureText: true,
      controller: passController,
      validator: (input) {
        password = input;
        if (input.isEmpty) {
          return "this field is required";
        }
        if (input.length < 7) {
          return "The Password must be at least 7 character and include a combination of uppercase , lowercase letters & numbers";
        }
        if (!validateStructure(input)) {
          return "The Password must be at least 7 character and include a combination of uppercase , lowercase letters & numbers";
        }

        return null;
      },
      onSaved: (value) {
        pass = value;
      },
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        errorMaxLines: 3,
        prefixIcon: Icon(
          Icons.lock_outlined,
          color: kTextLightColor,
        ),
        contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kTextLightColor, width: 15.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
    final nameFeild = TextFormField(
      controller: _nameController,
      obscureText: false,
      style: h5,
      validator: nameValidation,
      decoration: textInputDecoratuon.copyWith(
          hintText: 'Full Name', prefixIcon: Icon(Icons.person)),
      onSaved: (value) {
        name = value;
      },
    );
    final emailField = TextFormField(
      obscureText: false,
      validator: emailValidation,
      controller: _emailController,
      keyboardType: TextInputType.number,
      style: h5,
      decoration: textInputDecoratuon.copyWith(
          hintText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
      onSaved: (value) {
        email = value;
      },
    );
    final requestButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        disabledColor: Colors.grey,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _signUpUser(_emailController.text, passController.text, context,
                _nameController.text, valueChoose, genderGroupValue);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('please fill again'),
              duration: Duration(seconds: 2),
            ));
          }
        },
        child: Text("Get Started",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      appBar: myAppBar1(
        context,
        title: 'Create Account',
        iconButton: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                      onSaved: (newValue) {
                        valueChoose = newValue;
                      },
                      items: listItems.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text('Academic Level: ' + valueItem),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 20.0,
                      width: double.infinity,
                      child:
                          Text("Gender", textAlign: TextAlign.left, style: h4),
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
                              },
                            ),
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
                    SizedBox(height: 15.0),
                    emailField,
                    SizedBox(height: 35.0),
                    passwordField2,
                    SizedBox(height: 35.0),
                    passwordField,
                    SizedBox(height: 35.0),
                    requestButon,
                    SizedBox(
                      height: 35.0,
                    ),
                    SizedBox(
                      child: TextButton(
                        child: Text("Already have account? Sign In.",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )),
        ),
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
