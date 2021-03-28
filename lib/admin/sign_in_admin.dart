import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  SignPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController pass2Controller = TextEditingController();
  var password = "";
  var userName = "";
  var confirmPassword = "";
  var gray = Colors.grey;
  var red = Colors.red;
  var color = Colors.grey;
  var textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      obscureText: true,
      validator: (input) {
        if (input.isEmpty) {
          return "this field is required";
        }
        if (input.length < 7) {
          return "The Password must be at least 7 character and include a combination of uppercase , lowercase letters & numbers";
        }
        if (input != password) {
          return "The Password and its confirmation do not match";
        }
        if (!validateStructure(input)) {
          return "The Password must be at least 7 character and include a combination of uppercase , lowercase letters & numbers";
        }

        return null;
      },
      controller: passController,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "*******",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final userNameField = TextFormField(
      obscureText: true,
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
          hintText: "username",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: _submit,
        child: Text("Get Started",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff14213C),
      ),
      body: buildCenter(passwordField, loginButon, userNameField),
    );
  }

  Widget buildCenter(TextFormField passwordField, Material loginButon,
      TextFormField userNameField) {
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
                  Text("Welcome Back :)",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                      "Enter your Username and password for signing in. Thanks",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                        fontSize: 16,
                        color: Colors.grey,
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("Username",
                        textAlign: TextAlign.start,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15)),
                  ),
                  SizedBox(height: 10.0),
                  userNameField,
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("Password",
                        textAlign: TextAlign.left,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15)),
                  ),
                  SizedBox(height: 10.0),
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
    }
    if (passController.text.length < 7) {
      /*setState(() {
        password="Password Must be at least 7 numbers";
        textColor=Colors.red;
      });*/
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
