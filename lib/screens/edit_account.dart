import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EditAccountPage extends StatefulWidget {
  EditAccountPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EditAccountPage createState() => _EditAccountPage();
}

class _EditAccountPage extends State<EditAccountPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String valueChoose;

  List listItems = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  String genderGroupValue;

  bool isGenderSelected = false;

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameFeild = TextFormField(
        validator: nameValidation,
        obscureText: false,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Full Name', prefixIcon: Icon(Icons.person)));
    final emailField = TextFormField(
        validator: emailValidation,
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Email', prefixIcon: Icon(Icons.email)));

    final submitButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        disabledColor: Colors.grey,
        onPressed: isGenderSelected
            ? () {
                _formKey.currentState.validate();
              }
            : null,
        child: Text("Confirm Changes",
            textAlign: TextAlign.center, style: yellowButtonsTextStyle),
      ),
    );
//arrow_back_ios

    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'Edit Account ',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20.0,
                          spreadRadius: 0.5,
                          offset: Offset(1.0, 1.0)),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                nameFeild,
                SizedBox(height: 15.0),
                emailField,
                SizedBox(height: 15.0),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(5.0)))),
                  hint: Text('Academic Level'),
                  icon: Icon(Icons.arrow_drop_down),
                  style: h5,
                  isExpanded: true,
                  autofocus: false,
                  value: valueChoose,
                  onChanged: (newValue) {
                    setState(() {
                      valueChoose = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'This field is required.' : null,
                  items: listItems.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text('Academic Level: ' + valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: Text("Gender", textAlign: TextAlign.left, style: h4),
                ),
                SizedBox(height: 15),
                Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  height: 55,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                            value: 'Male',
                            groupValue: genderGroupValue,
                            activeColor: Colors.orange,
                            onChanged: (val) {
                              setState(() {
                                genderGroupValue = val;
                                isGenderSelected = true;
                              });
                            }),
                        Text('Male'),
                        Radio(
                            value: 'Female',
                            groupValue: genderGroupValue,
                            activeColor: Colors.orange,
                            onChanged: (val) {
                              setState(() {
                                genderGroupValue = val;
                                isGenderSelected = true;
                              });
                            }),
                        Text('Female'),
                      ]),
                ),
                SizedBox(height: 15),
                submitButon,
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
