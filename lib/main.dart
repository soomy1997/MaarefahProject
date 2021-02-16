import 'package:flutter/material.dart';
import 'utils/constants.dart';

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
      home: MyHomePage(title: 'Flutter Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        obscureText: false,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Email', prefixIcon: Icon(Icons.email)));
    final passwordField = TextField(
        obscureText: true,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: '******', prefixIcon: Icon(Icons.lock)));
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Get started",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 35.0,
                  child: Text("Welcome Back :)",
                      textAlign: TextAlign.center, style: h1),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (50.0 / 812),
                  child: Text(
                      "Enter your email and password for signing in. Thanks ",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 15.0,
                  width: double.infinity,
                  child: Text("Email",
                      textAlign: TextAlign.left,
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ),
                SizedBox(height: 10.0),
                emailField,
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 15.0,
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
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 35.0,
                  child: Text("Forgot password? Reset here.",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 35.0,
                  child: Text("No account? Create one.",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
