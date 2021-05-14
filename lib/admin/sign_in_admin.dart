import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/admin_homepage.dart';
import 'package:flutter_app_1/admin/services/admin_flutterfire.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:provider/provider.dart';

class AdminSignPage extends StatefulWidget {
  AdminSignPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AdminSignPageState createState() => _AdminSignPageState();
}

class _AdminSignPageState extends State<AdminSignPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  var password = "";

  var color = Colors.grey;
// Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _loginUser(String email, String password, BuildContext context) async {
    CurrentAdmin _currentUser =
        Provider.of<CurrentAdmin>(context, listen: false);
    try {
      String _returnString = await _currentUser.loginUser(email, password);

      if (_returnString == 'success') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AdminDashboard(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Icorrect login info'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      obscureText: _obscureText,
      validator: (input) {
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
      controller: passController,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: color,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: _togglePasswordStatus,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "*******",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final emailNameField = TextFormField(
      obscureText: false,
      controller: emailController,
      validator: emailValidation,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.email,
            color: color,
          ),
          contentPadding: EdgeInsets.all(20.0),
          hintText: "Email",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.50,
        padding: EdgeInsets.all(20.0),
        onPressed: _submit,
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
      ),
    );

    return Scaffold(
      body: buildCenter(passwordField, loginButon, emailNameField),
    );
  }

  Widget buildCenter(TextFormField passwordField, Material loginButon,
      TextFormField emailNameField) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                    height: 15,
                  ),
                  Text("Enter your Email and password for signing in. Thanks",
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
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Text("Email",
                        textAlign: TextAlign.start,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15)),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: emailNameField,
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: Text("Password",
                        textAlign: TextAlign.left,
                        style: style.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15)),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: passwordField,
                  ),
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
      _loginUser(emailController.text, passController.text, context);
    }
    if (passController.text.length < 7) {}
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
