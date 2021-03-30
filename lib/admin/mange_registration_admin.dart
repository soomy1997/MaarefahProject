import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/add_new_registration_admin.dart';
import 'package:flutter_app_1/utils/constants.dart';

class ManageRegistration extends StatefulWidget {
  ManageRegistration({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ManageRegistrationState createState() => _ManageRegistrationState();
}

class _ManageRegistrationState extends State<ManageRegistration> {
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

  var option = "";
  var gray = Colors.grey;
  var red = Colors.red;
  var color = Colors.black;
  var textColor = Colors.black;
  final List<String> options = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    final optionFild = DropdownButtonFormField(
      style: TextStyle(fontSize: 11),
      isDense: true,
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 16,
      ),
      iconEnabledColor: Theme.of(context).primaryColor,
      items: options.map((priority) {
        return DropdownMenuItem(
          value: priority,
          child: Text(
            priority,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
          hintText: "learner",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 2.0),
              borderRadius: BorderRadius.circular(5.0))),
      validator: (input) => option == null ? "Please Select Option" : null,
      onChanged: (val) {
        setState(() {
          option = val;
        });
      },
    );
    final sessionName = DropdownButtonFormField(
      style: TextStyle(fontSize: 11),
      isDense: true,
      icon: Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 16,
      ),
      iconEnabledColor: Theme.of(context).primaryColor,
      items: options.map((priority) {
        return DropdownMenuItem(
          value: priority,
          child: Text(
            priority,
            style: TextStyle(fontSize: 11, color: Colors.black),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
          hintText: "session name",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: color, width: 2.0),
              borderRadius: BorderRadius.circular(5.0))),
      validator: (input) => option == null ? "Please Select Option" : null,
      onChanged: (val) {
        setState(() {
          option = val;
        });
      },
    );

    final add_btn = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(6.0),
      color: accentYellow,
      child: MaterialButton(
        height: 50,
        minWidth: 190,
        padding: EdgeInsets.fromLTRB(48.0, 0, 48.0, 0),
        onPressed: _submit,
        child: Text(
          "Add New Registration",
          style: yellowButtonsTextStyle,
        ),
      ),
    );

    return Scaffold(
      appBar: myAppBar1(context,
          title: 'Manage Registeration',
          iconButton: IconButton(
            icon: Icon(Icons.menu),
            iconSize: 40,
            onPressed: () => (0),
          )),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(50),
                child: Text(
                  'Managing Registeration',
                  style: h1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registrations',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Table(
                      //defaultColumnWidth: FixedColumnWidth(110.0),
                      border: TableBorder.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1),
                      children: [
                        TableRow(children: [
                          optionFild,
                          sessionName,
                          Container(
                            color: Colors.grey,
                          )
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                ),
                                Icon(Icons.search)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search',
                                ),
                                Icon(Icons.search)
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey,
                          )
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sara Ehab',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Intro to OPP1',
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                  Icon(Icons.notifications, color: Colors.grey),
                                  Icon(Icons.edit, color: Colors.grey)
                                ],
                              )),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Ahmed Nasser',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Intro to OPP1',
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                  Icon(Icons.notifications, color: Colors.grey),
                                  Icon(Icons.edit, color: Colors.grey)
                                ],
                              )),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    add_btn
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    Navigator.push(context, MaterialPageRoute(builder: (ctz) {
      return AddNewRegister();
    }));
  }
}
