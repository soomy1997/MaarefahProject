import 'package:flutter/material.dart';
import 'package:flutter_app_1/screens/sign_in_page.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SendEmailPage extends StatefulWidget {
  SendEmailPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SendEmailPage createState() => _SendEmailPage();
}

class _SendEmailPage extends State<SendEmailPage> {
  String _email;
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
          Text("Reset link has been sent\n to $_email"),
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

  TextEditingController _emailConroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
// To remove present shwoing toast
    fToast.removeCustomToast();

// To clear the queue
    fToast.removeQueuedCustomToasts();

    final sendEmailButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            CurrentUser auth = Provider.of<CurrentUser>(context, listen: false);
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              await auth.sendPassResetEmail(_email);
              print('passowrd reset email sent');
              _showToast();
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SignInPage(),
              //   ),
              //   (route) => false,
              // ).then((_) => _showToast());
            }
          } catch (e) {
            print(e);
          }
        },
        child: Text("Send",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );

    return Scaffold(
      appBar: myAppBar4(
        context,
        title: 'Forgot password',
      ),
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
                Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      obscureText: false,
                      validator: emailValidation,
                      style: h5,
                      controller: _emailConroller,
                      decoration: textInputDecoratuon.copyWith(
                        hintText: 'example@gmail.com',
                        prefixIcon: Icon(Icons.email),
                        labelStyle: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
                // emailField,
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
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
