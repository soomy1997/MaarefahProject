import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/root/root.dart';
import 'package:flutter_app_1/sign_in_page.dart';
import 'package:flutter_app_1/services/flutterfire.dart';
import 'package:flutter_app_1/sign_up_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     Provider<AuthenticationService>(
    //       create: (_) => AuthenticationService(FirebaseAuth.instance),
    //     ),
    //     StreamProvider(
    //       create: (context) =>
    //           context.read<AuthenticationService>().authStateChanges,
    //       initialData: null,
    //     )
    //   ],
    // child: MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   // initialRoute: '/',
    //   // routes: {
    //   //   '/': (context) => SignUpPage(),
    //   // },
    //   theme: ThemeData(
    //     primarySwatch: Colors.orange,
    //   ),
    //   home: AuthenticationWrapper(),
    // ),
    // );
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: OurRout(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    if (firebaseuser != null) {
      return SignUpPage();
    }
    return SignInPage();
  }
}
