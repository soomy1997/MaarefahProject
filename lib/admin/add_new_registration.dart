import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/admin_compnent/successful_register_dialog.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:intl/intl.dart';

class AddNewRegister extends StatefulWidget {
  AddNewRegister({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AddNewRegisterState createState() => _AddNewRegisterState();
}

class _AddNewRegisterState extends State<AddNewRegister> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController pass2Controller = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime _dateTime = DateTime.now(); // to get Date and Time
  TextEditingController _dateController =
      TextEditingController(); // use to set/get Text to Edittext
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  var userName = "";
  var email = "";
  var option = "";
  var color = Colors.black38;
  var textColor = Colors.black;
  final List<String> options = [
    "Introduction to OOP1",
    "Introduction to OOP2",
    "Introduction to Math"
  ];

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return "This field is required";
        }

        return null;
      },
      readOnly: true,
      controller: _dateController,
      onTap: () {
        _handleDatePicker();
      },
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.date_range_rounded,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "Date",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final userNameField = TextFormField(
      controller: pass2Controller,
      validator: (input) {
        userName = input;
        if (input.isEmpty) {
          return "This field is required";
        }

        return null;
      },
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.perm_identity,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "Learner Name",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final emailField = TextFormField(
      controller: emailContoller,
      validator: (input) {
        email = input;
        if (input.isEmpty) {
          return "This field is required";
        }
        if (!isEmail(input)) {
          return 'Please enter your email address in format yourname@example.com';
        }

        return null;
      },
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.email,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "Learner Email",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white60, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
    );
    final optionFild = DropdownButtonFormField(
      style: TextStyle(fontSize: 18),
      isDense: true,
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 28,
      ),
      iconEnabledColor: Theme.of(context).primaryColor,
      items: options.map((priority) {
        return DropdownMenuItem(
          value: priority,
          child: Text(
            priority,
            style: TextStyle(fontSize: 16, color: Colors.black38),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
          errorMaxLines: 3,
          prefixIcon: Icon(
            Icons.file_copy,
            color: color,
          ),
          contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
          hintText: "current session",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 15.0),
              borderRadius: BorderRadius.circular(5.0))),
      validator: (input) =>
          option.isEmpty ? "Please Choose current session" : null,
      onChanged: (val) {
        setState(() {
          option = val;
        });
      },
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: _submit,
        child: Text("Add New registration",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.normal)),
      ),
    );

    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Manage Registration',
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: 'Sign Out',
              backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
      body: buildCenter(
          passwordField, loginButon, userNameField, emailField, optionFild),
    );
  }

  Widget buildCenter(
      TextFormField passwordField,
      Material loginButon,
      TextFormField userNameField,
      TextFormField emailFiled,
      DropdownButtonFormField optionFild) {
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
                children: <Widget>[
                  Text("Add New registration",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 30.0),
                  userNameField,
                  SizedBox(height: 30.0),
                  emailFiled,
                  SizedBox(height: 30.0),
                  optionFild,
                  SizedBox(height: 30.0),
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
      //
      print("called");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog1();
          });
      /*Navigator.push(context, MaterialPageRoute(builder: (c) {
        return AlertDialog();
      }));*/
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void _handleDatePicker() async {
    final DateTime selectecDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (selectecDate != null && selectecDate != _dateTime) {
      setState(() {
        _dateTime = selectecDate;
      });
      _dateController.text = dateFormat.format(_dateTime);
    }
  }
}
