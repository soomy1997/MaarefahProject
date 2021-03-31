import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/admin_compnent/sign_out_dialog_box_admin.dart';
import 'package:flutter_app_1/admin/admin_homepage.dart';
import 'package:flutter_app_1/admin/admin_session_details.dart';
import 'package:flutter_app_1/admin/manage_session.dart';
import 'package:flutter_app_1/admin/manage_tutoring_request.dart';
import 'package:flutter_app_1/admin/mange_registration_admin.dart';
import 'package:flutter_app_1/utils/constants.dart';

import '../session_requests.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: secondaryDarkBlue,
            child: Column(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 15,
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: secondaryDarkBlue,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminDashboard(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.query_builder_rounded,
              color: secondaryDarkBlue,
            ),
            title: Text(
              'Session Requests',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionRequestPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.margin,
              color: secondaryDarkBlue,
            ),
            title: Text(
              'Manage sessions',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageSessionsPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              color: secondaryDarkBlue,
            ),
            title: Text(
              'Manage Registeration',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageRegistration(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.file_copy_outlined,
              color: secondaryDarkBlue,
            ),
            title: Text(
              'Tutoring Request',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageTutoingRequest(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: accentOrange,
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SignOutCustomDialogBox(
                    descriptions: "Are you sure you want to sign out?",
                    text: "Yes",
                    text2: "No",
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
