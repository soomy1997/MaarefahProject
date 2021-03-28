import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/manage_session.dart';
import 'package:flutter_app_1/admin/manage_tutoring_request.dart';
import 'package:flutter_app_1/admin/mange_registration_admin.dart';
import 'package:flutter_app_1/admin/admin_compnent/sign_out_dialog_box_admin.dart';
import 'package:flutter_app_1/admin/session_requests.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DashBoard());
}

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SignOutCustomDialogBox(
            title: "Are You ",
            descriptions: "Are You Sure To Sign Out?",
            text: "Yes",
            text2: "No",
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Admin Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff14213C),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Admin Dashboard',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SessionRequestPage();
                        }));
                      },
                      child: card2(
                          'Session Requests', Icons.query_builder_rounded),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ManageSessionsPage();
                          }));
                        },
                        child: card2('Manage Sessions', Icons.margin)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ManageRegistration();
                        }));
                      },
                      child: card2('Manage Registration', Icons.auto_stories),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ManageTutoingRequestPage();
                          }));
                        },
                        child: card2('Totoring requests', Icons.file_copy)),
                  ],
                )
              ],
            ),
          ),
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
        ));
  }

  Widget btn(IconData data) {
    return RawMaterialButton(
        fillColor: Color(0xff14213C),
        splashColor: Color(0xff14213C),
        shape: new CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(
                width: 30.0,
                height: 30.0,
                child: Center(
                  child: Icon(
                    data,
                    color: Colors.white,
                  ),
                ))
          ]),
        ),
        onPressed: () {});
  }

  Widget card2(String text, IconData data) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 1.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0), // shadow direction: bottom right
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(10),
      height: 140,
      width: 140,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            btn(data),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
