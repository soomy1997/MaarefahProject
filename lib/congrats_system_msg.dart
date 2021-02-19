import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(Congrats());
}

class Congrats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Congratulations System Message',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CongratsPage(title: 'Join Us as a Tutor'),
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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Got it",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
//arrow_back_ios
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff14213C),
        actions: [
          IconButton(
              icon: Icon(Icons.close_rounded, color: Colors.white),
              onPressed: () => {})
        ],
        leading: Icon(Icons.arrow_back_ios, color: Colors.white),
        title: Text(
          "System message",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                height: 80.0,
                child: Text(
                    "\nYour request to Join as a tutor is sent successfully\nplease wait for approval ",
                    textAlign: TextAlign.center,
                    style: h5),
              ),
              SizedBox(
                  height: 300.0,
                  child: Image(image: AssetImage('images/pic5.png'))),
              SizedBox(height: 15),
              loginButon,
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
    );
  }
}
