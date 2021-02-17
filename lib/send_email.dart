import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(SendEmail());
}

class SendEmail extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Send Email',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SendEmailPage(title: 'Send Email'),
    );
  }
}

class SendEmailPage extends StatefulWidget {
  SendEmailPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SendEmailPage createState() => _SendEmailPage();
}

class _SendEmailPage extends State<SendEmailPage> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var email = "";

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        obscureText: false,
        validator: (input) {
          email = input;
          if (input.isEmpty) {
            return "this field is required";
          }
          if (!validateStructure(input)) {
            return "Please enter your email address in theis format \nyourname@exampl.com";
          }
          return null;
        },
        controller: emailController,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Email', prefixIcon: Icon(Icons.email)));

    final sendEmailButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: _submit,
        child: Text(
          "Send",
          textAlign: TextAlign.center,
          style: yellowButtonsTextStyle,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff14213C),
          actions: [
            IconButton(icon: Icon(Icons.close_rounded), onPressed: () => {})
          ],
          leading: Icon(Icons.arrow_back_ios)),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                  child: Text("Forgot Password?",
                      textAlign: TextAlign.center, style: h1),
                ),
                SizedBox(
                    height: 200.0,
                    child: Image(image: AssetImage('images/pic1.png'))),
                SizedBox(
                  height: 80.0,
                  child: Text(
                      "\nDon't worry, enter your email address and we'll send you a link to reset your password ",
                      textAlign: TextAlign.center,
                      style: h5),
                ),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Email", textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 10.0),
                emailField,
                SizedBox(
                  height: 35.0,
                ),
                sendEmailButton,
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 35.0,
                ),
              ],
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
    if (emailController.text.length < 7) {
      /*setState(() {
        password="Password Must be at least 7 numbers";
        textColor=Colors.red;
      });*/
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
