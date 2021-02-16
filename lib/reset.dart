import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:flutter_app_1/verification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResetHomePage(title: 'Flutter Login'),
    );
  }
}

class ResetHomePage extends StatefulWidget {
  ResetHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ResetHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController pass2Controller = TextEditingController();
  var password = "";
  var confirmPassword = "";
  var gray = Colors.grey;
  var red = Colors.red;
  var color = Colors.grey;
  var textColor = Colors.black;

  @override
  void dispose() {
    // TODO: implement dispose
    this.passController.dispose();
    this.pass2Controller.dispose();
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
          hintText: "******",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final passwordField2 = TextFormField(
      obscureText: true,
      controller: pass2Controller,
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
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "******",
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
        onPressed: () {
          _submit();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VerificationPage()),
          );
        },
        child: Text(
          "Reset",
          textAlign: TextAlign.center,
          style: yellowButtonsTextStyle,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff14213C),
        actions: [
          new IconButton(
            icon: Icon(Icons.close_rounded),
            tooltip: 'Closes screen',
            onPressed: () => (0),
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'return to previous screen',
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: buildCenter(passwordField, loginButon, passwordField2),
    );
  }

  Widget buildCenter(TextFormField passwordField, Material loginButon,
      TextFormField passwordField2) {
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
                  Text("Reset your password",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("New Password",
                        textAlign: TextAlign.start,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15)),
                  ),
                  SizedBox(height: 10.0),
                  passwordField2,
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 20.0,
                    width: double.infinity,
                    child: Text("Confirm New Password",
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
