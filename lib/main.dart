import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/add_session.dart';
import 'package:flutter_app_1/authentication.dart';
import 'package:flutter_app_1/component/Reviews_card.dart';
import 'package:flutter_app_1/component/info_card.dart';
import 'package:flutter_app_1/course_details.dart';
import 'package:flutter_app_1/edit_account.dart';
import 'package:flutter_app_1/admin/edit_session_details.dart';
import 'package:flutter_app_1/home_page.dart';
import 'package:flutter_app_1/no_internet_connection.dart';
import 'package:flutter_app_1/no_search_found.dart';
import 'package:flutter_app_1/notification.dart';
import 'package:flutter_app_1/profile.dart';
import 'package:flutter_app_1/profile.tutor.dart';
import 'package:flutter_app_1/profile_visitor.dart';
import 'package:flutter_app_1/reset.dart';
import 'package:flutter_app_1/send_email.dart';
import 'package:flutter_app_1/admin/session_details.dart';
import 'package:flutter_app_1/utils/tabbed_app.dart';
import 'package:flutter_app_1/congrats.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Profile(),
      },
      title: 'Flutter login',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //  home: MyHomePage(),
    );
  }
}
