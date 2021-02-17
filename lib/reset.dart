import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter login',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResetHomePage(title: 'Flutter Login'),
    );
  }
}

class ResetHomePage extends StatefulWidget {
  ResetHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    final passwordField2 = TextFormField(
      obscureText: true,
      controller: pass2Controller,
      validator: (input) {
        password = input;
        if (input.isEmpty) {
          return "This field is required";
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
          hintText: "*******",
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
        child: Text("Reset",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff14213C),
      ),
      body: buildCenter(passwordField, loginButon, passwordField2),
    );
  }

  Center myCode(BuildContext context, Material loginButon) {
    return Center(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Rest Your  Password",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 28.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Flexible(
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                labelText: "New Password",
                                labelStyle: TextStyle(fontSize: 18.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (input) {
                                password = input;
                                if (input.isEmpty) {
                                  return "Please Enter a New Password";
                                }
                                if (!validateStructure(input)) {
                                  return "Your Password Must Be Strong";
                                }

                                return null;
                              },
                              onSaved: (input) => password = input,
                              initialValue: password,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: "Confirm New Password",
                              labelStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (input) {
                              if (input.isEmpty) {
                                return "Please Confirm Password";
                              }
                              if (!validateStructure(input)) {
                                return "Your Password Must Be Strong";
                              }

                              if (input != password) {
                                return "Password Must be matched";
                              }

                              return null;
                            },
                            onSaved: (input) => confirmPassword = input,
                            initialValue: confirmPassword,
                          ),
                        ),
                        loginButon,
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
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
