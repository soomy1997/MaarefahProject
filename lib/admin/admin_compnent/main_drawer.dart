import 'package:flutter/material.dart';
import 'package:flutter_app_1/component/dialogs.dart';
import 'package:flutter_app_1/admin/admin_homepage.dart';
import 'package:flutter_app_1/admin/admin_root/admin_root.dart';
import 'package:flutter_app_1/admin/manage_session.dart';
import 'package:flutter_app_1/admin/manage_tutoring_request.dart';
import 'package:flutter_app_1/admin/mange_registration_admin.dart';
import 'package:flutter_app_1/admin/services/admin_flutterfire.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:provider/provider.dart';
import '../session_requests.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
              'Manage Registerations',
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
              'Tutoring Requests',
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
            onTap: () async {
              final action = await WarningDialogs.yesAbortDialog(
                  context, 'Sign Out', 'Are you sure you want to sign out?');
              if (action == DialogAction.yes) {
                CurrentAdmin _currentAdmin =
                    Provider.of<CurrentAdmin>(context, listen: false);

                String _returnString = await _currentAdmin.signOut();
                if (_returnString == 'success') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminRoute(),
                    ),
                    (route) => false,
                  );
                }
              } else {
                setState(() => null);
              }
            },
          ),
        ],
      ),
    );
  }
}
