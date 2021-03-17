import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/home_page.dart';
import 'package:flutter_app_1/no_internet_connection.dart';
import 'package:flutter_app_1/notification.dart';
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
        '/': (context) => NotificationPage(),
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
