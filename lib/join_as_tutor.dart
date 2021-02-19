import 'package:flutter/material.dart';
import 'constants.dart';

void main() {
  runApp(JoinTutor());
}

class JoinTutor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Join Us as a Tutor',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: JoinTutorPage(title: 'Join Us as a Tutor'),
    );
  }
}

class JoinTutorPage extends StatefulWidget {
  JoinTutorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _JoinTutorPage createState() => _JoinTutorPage();
}

class _JoinTutorPage extends State<JoinTutorPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String valueChoose;
  List listItems = ["4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  String genderGroupValue = '';
  //checkboxes
  bool _sunChecked = false;
  bool _monChecked = false;
  bool _tueChecked = false;
  bool _wedChecked = false;
  bool _thuChecked = false;
  bool _friChecked = false;
  bool _satChecked = false;

  bool _sixChecked = false;
  bool _sevenChecked = false;
  bool _eightChecked = false;
  bool _nineChecked = false;

  @override
  Widget build(BuildContext context) {
    final nameFeild = TextField(
        obscureText: false,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Full Name', prefixIcon: Icon(Icons.person)));
    final phoneField = TextField(
        obscureText: false,
        keyboardType: TextInputType.number,
        style: h5,
        decoration: textInputDecoratuon.copyWith(
            hintText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_android_outlined)));
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffF9A21B),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Request",
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
          "Request to Join as a Tutor",
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
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                hint: Text('Academic Level'),
                icon: Icon(Icons.arrow_drop_down),
                style: h5,
                isExpanded: true,
                value: valueChoose,
                onChanged: (newValue) {
                  setState(() {
                    valueChoose = newValue;
                  });
                },
                items: listItems.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text('Academic Level: ' + valueItem),
                  );
                }).toList(),
              ),
              SizedBox(height: 15.0),
              phoneField,
              SizedBox(
                height: 15.0,
              ),
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
                            genderGroupValue = val;
                            setState(() {});
                          }),
                      Text('Male'),
                      Radio(
                          value: 'Female',
                          groupValue: genderGroupValue,
                          activeColor: Colors.orange,
                          onChanged: (val) {
                            genderGroupValue = val;
                            setState(() {});
                          }),
                      Text('Female'),
                    ]),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 20.0,
                width: double.infinity,
                child: Text("Suitable Tutoring Days",
                    textAlign: TextAlign.left, style: h4),
              ),
              SizedBox(height: 15),
              new CheckboxListTile(
                  title: Text("Sunday"),
                  value: _sunChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _sunChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("Monday"),
                  value: _monChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _monChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("Tuesday"),
                  value: _tueChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _tueChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("Wednesday"),
                  value: _wedChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _wedChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("Thursday"),
                  value: _thuChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _thuChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("Friday"),
                  value: _friChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _friChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("Saturday"),
                  value: _satChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _satChecked = value;
                    });
                  }),
              SizedBox(height: 15.0),
              SizedBox(
                height: 20.0,
                width: double.infinity,
                child: Text("Suitable time(s) fr holding the session",
                    textAlign: TextAlign.left, style: h4),
              ),
              SizedBox(height: 15.0),
              new CheckboxListTile(
                  title: Text("6 PM"),
                  value: _sixChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _sixChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("7 PM"),
                  value: _sevenChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _sevenChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("8 PM"),
                  value: _eightChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _eightChecked = value;
                    });
                  }),
              new CheckboxListTile(
                  title: Text("9 PM"),
                  value: _nineChecked,
                  activeColor: Colors.orange,
                  onChanged: (bool value) {
                    setState(() {
                      _nineChecked = value;
                    });
                  }),
              SizedBox(height: 15.0),
              SizedBox(
                height: 20.0,
                width: double.infinity,
                child: Text("Overview of your teaching method",
                    textAlign: TextAlign.left, style: h4),
              ),
              SizedBox(height: 15.0),
              TextField(
                maxLines: 9,
                style: h5,
                decoration: textInputDecoratuon.copyWith(
                    hintText: "Enter your text here"),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 35.0),
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
