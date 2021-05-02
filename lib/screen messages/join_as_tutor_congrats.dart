import 'package:flutter/material.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:flutter_app_1/utils/tabbed_app.dart';

class Congrats extends StatefulWidget {
  @override
  _Congrats createState() => _Congrats();
}

class _Congrats extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    final gotItButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TabbedApp()),
              (route) => false);
        },
        child: Text(
          "Got it",
          textAlign: TextAlign.center,
          style: yellowButtonsTextStyle,
        ),
      ),
    );

    return Scaffold(
      appBar: myAppBar4(
        context,
        title: 'System Message',
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("Congratulations!", style: h1),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Your request to Join as a tutor is sent successfully, please wait for approval",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage("images/pic6.png"),
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.99,
                ),
                SizedBox(
                  height: 30,
                ),
                gotItButton,
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
