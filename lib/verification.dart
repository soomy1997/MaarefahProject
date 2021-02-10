import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'verification_code_input.dart';
import 'constants.dart';

void main() {
  runApp(VerificationScreen());
}

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VerificationPage(title: 'Flutter Reset Password'),
    );
  }
}

class VerificationPage extends StatefulWidget {
  VerificationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<VerificationPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  //bool _isButtonDisabled;

  @override
  Widget build(BuildContext context) {
    final verifyButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () => (0),
        child: Text("Verify",
            textAlign: TextAlign.center,
            style: yellowButtonsTextStyle,),
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
          onPressed: () => (0),
        ),
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
                  height: 45.0,
                  child: Text(
                    "Verification",
                    textAlign: TextAlign.center,
                    style: h1,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Text(
                      "Enter the verification code we just sent you on your email address.",
                      textAlign: TextAlign.center,
                      style: h5),
                ),
                SizedBox(
                  height: 35.0,
                ),
                CountdownTimer(
                  endTime: endTime,
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    if (time == null) {
                      return Text(
                        '\u{26A0}Your session has expired, please go back to previous screen',
                        style: style.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                        ),
                      );
                    }
                    return Text(
                      '${time.sec}',
                      style: style.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 50,
                      ),
                    );
                  },
                ),
                VerificationCodeInput(
                  keyboardType: TextInputType.number,
                  length: 4,
                  autofocus: true,
                  onCompleted: (String value) {
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 35.0,
                  child: Text("Didn't recieve a code?",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      )),
                ),
                TextButton(
                  child: Text(
                    'Resend',
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                      color: Color(0xffF9A21B),
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    print('Pressed');
                  },
                ),
                verifyButton,
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
}
