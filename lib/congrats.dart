import 'package:flutter/material.dart';
import 'utils/constants.dart';
import './reset.dart';

void main() {
  runApp(Congrats());
}

class Congrats extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Congrats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CongratsPage(title: 'Congrats'),
    );
  }
}

class CongratsPage extends StatefulWidget {
  CongratsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CongratsPage createState() => _CongratsPage();
}

class _CongratsPage extends State<CongratsPage> {
  @override
  Widget build(BuildContext context) {
    final sendEmailButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResetHomePage()),
          );
        },
        child: Text(
          "Got it",
          textAlign: TextAlign.center,
          style: yellowButtonsTextStyle,
        ),
      ),
    );

    return Scaffold(
      appBar: myAppBar1(context,
          title: "System message",
          iconButton: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(36, 70, 36, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                  child: Text("Congratulations!",
                      textAlign: TextAlign.center, style: h1),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (44 / 812),
                  child: Text(
                      "Your request to Join as a tutor is sent successfully, please wait for approval",
                      textAlign: TextAlign.center,
                      style: h5),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (340 / 812),
                  child: Image(image: AssetImage('images/pic6.png')),
                ),
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
}
