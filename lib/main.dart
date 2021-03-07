import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/authentication.dart';
import 'package:flutter_app_1/course_details.dart';
import 'package:flutter_app_1/edit_account.dart';
import 'package:flutter_app_1/home_page.dart';
import 'package:flutter_app_1/join_as_tutor.dart';
import 'package:flutter_app_1/no_search_found.dart';
import 'package:flutter_app_1/profile.dart';
import 'package:flutter_app_1/reset.dart';
import 'package:flutter_app_1/verification.dart';

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
