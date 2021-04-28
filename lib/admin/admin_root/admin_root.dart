import 'package:flutter/material.dart';
import 'package:flutter_app_1/admin/admin_homepage.dart';
import 'package:flutter_app_1/admin/services/admin_flutterfire.dart';
import 'package:flutter_app_1/admin/sign_in_admin.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class AdminRoute extends StatefulWidget {
  @override
  _AdminRouteState createState() => _AdminRouteState();
}

class _AdminRouteState extends State<AdminRoute> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //get the state, check current admin, set AuthStatus based on state
    CurrentAdmin _currentUser =
        Provider.of<CurrentAdmin>(context, listen: false);
    String _returnString = await _currentUser.onStartup();
    if (_returnString == 'success') {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = AdminSignPage();
        break;
      case AuthStatus.loggedIn:
        retVal = AdminDashboard();
        break;
      default:
    }
    return retVal;
  }
}
