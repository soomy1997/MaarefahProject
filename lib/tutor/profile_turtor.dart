import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/screens/About.dart';
import 'package:flutter_app_1/screens/contact_us.dart';
import 'package:flutter_app_1/screens/join_as_tutor.dart';
import 'package:flutter_app_1/utils/constants.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfilePage(),
    );
  }
}
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    elevatedButton() {
      return RaisedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.login),
        label: Text("Sign Out"),
        color: Colors.grey[300],
      );
    }
    containerElement() {
      return Padding(
        padding: const EdgeInsets.only(
            left: 6.0, right: 6.0, top: 6.0, bottom: 10.0),
        child: Container(
          child: ListView(
            children: [
              customTutor(),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  ListTile(
                    leading: Icon(
                      Icons.photo_camera_front,
                      color: Colors.blue[800],
                    ),
                    title: Text("My zoom link",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.collections_bookmark_rounded,
                      color: Colors.orange,
                    ),
                    title: Text("Taught sessions",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Colors.greenAccent,
                    ),
                    title: Text("Change Password",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.rate_review_outlined,
                      color: Colors.deepPurple,
                    ),
                    title: Text("Reviews & Ratings",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinTutorPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.card_membership_outlined,
                        color: Colors.brown[200]),
                    title: Text("Certifications",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JoinTutorPage()),
                      );*/
                    },
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Support",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: Colors.red,
                    ),
                    title: Text("About Us",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutPage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.blue[200],
                    ),
                    title: Text("Contact Us",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Account()));
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  elevatedButton(),
                ],
              ),
            ],
          ),
        ),
      );
    }

      return Scaffold(
        appBar: myAppBar3(
          context,
          title: 'Account',
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Colors.white,
            child: containerElement(),
          ),
        ),
      );
   // }
  }

  Widget customTutor() {
    SizedBox st = SizedBox(
      height: 5,
    );
    SizedBox spacer = SizedBox(
      height: 5,
    );

    TextStyle style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle styles = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle valueStyle = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle editStyle = TextStyle(
      color: Colors.orange,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    Text name = Text(
      "Full Learner's Name",
      style: style,
    );
    Text edit = Text(
      "Edit",
      style: editStyle,
    );
    Text learner = Text(
      "Tutor",
      style: valueStyle,
    );

    Text gender = Text(
      "Gender",
      style: styles,
    );
    Text genderValue = Text(
      "value",
      style: valueStyle,
    );

    Text acaLevel = Text(
      "Academic Level",
      style: styles,
    );
    Text acaValue = Text(
      "value",
      style: valueStyle,
    );

    Text email = Text(
      "Email",
      style: styles,
    );
    Text emailValue = Text(
      "value",
      style: valueStyle,
    );

    Text phone = Text(
      "Phone Number",
      style: styles,
    );
    Text phoneValue = Text(
      "value",
      style: valueStyle,
    );

    boxShadow() {
      return BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 6, // soften the shadow
              spreadRadius: 3, //end the shadow
              offset: Offset(
                6.0, // Move to right 10  horizontally
                2.0, // Move to bottom 10 Vertically
              ),
            ),
            BoxShadow(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              blurRadius: 6, // soften the shadow
              spreadRadius: 3, //end the shadow
              offset: Offset(
                -6.0, // Move to right 10  horizontally
                -2.0, // Move to bottom 10 Vertically
              ),
            ),
          ]);
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: boxShadow(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Color(0XFFdae1eb),
                  child: Column(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.orange,
                        size: 12,
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  "AB",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              st,
              edit,
              st,
              name,
              st,
              learner,
              spacer,

              Divider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [acaLevel, acaValue, gender, genderValue],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [email, emailValue, phone, phoneValue],
                  )
                ],
              ), // Him
            ],
          ),
        ),
      ),
    );
  }
  
}
