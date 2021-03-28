import 'package:flutter/material.dart';
import 'package:flutter_app_1/TutorsList.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/sign_in_page.dart';
import 'package:flutter_app_1/utils/tabbed_app.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class OurRout extends StatefulWidget {
  @override
  _OurRoutState createState() => _OurRoutState();
}

class _OurRoutState extends State<OurRout> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get the state, check current User, set AuthStatus based on state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
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
        retVal = SignInPage();
        break;
      case AuthStatus.loggedIn:
        retVal = TabbedApp();
        break;
      default:
    }
    return retVal;
  }
}
