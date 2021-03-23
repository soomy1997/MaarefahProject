import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/add_new_registration_admin.dart';
import 'package:flutter_app_1/admin_homepage.dart';
import 'package:flutter_app_1/authentication.dart';
import 'package:flutter_app_1/component/home_card.dart';
import 'package:flutter_app_1/component/info_card.dart';
import 'package:flutter_app_1/custom_dialog_admin.dart';
import 'package:flutter_app_1/home_page.dart';
import 'package:flutter_app_1/join_as_tutor.dart';
import 'package:flutter_app_1/mange_registration_admin.dart';
import 'package:flutter_app_1/net/flutterfire.dart';
import 'package:flutter_app_1/no_internet_connection.dart';
import 'package:flutter_app_1/notification.dart';
import 'package:flutter_app_1/sign_in_admin.dart';
import 'package:flutter_app_1/sign_out_dialog_box_admin.dart';

import 'component/Reviews_card.dart';

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
        '/': (context) => HomePage(),
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
