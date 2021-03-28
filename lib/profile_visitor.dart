import 'package:flutter/material.dart';

import 'no_internet_connection.dart';

class LearnerAccountPage extends StatefulWidget {
  @override
  _LearnerAccountPageState createState() => _LearnerAccountPageState();
}

class _LearnerAccountPageState extends State<LearnerAccountPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle appBarTitleStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

    containerElement() {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 150,
                color: Color(0xff14213C),
                child: Center(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 70,
                        color: Colors.white70,
                      ),
                    ),
                    subtitle: Text(
                      "Sign in/ Create Account",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.orangeAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  ListTile(
                    leading: Icon(
                      Icons.collections_bookmark_rounded,
                      color: Colors.orange,
                    ),
                    title: Text("Registered sessions",
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
                      Icons.chat_bubble_outline,
                      color: Colors.deepPurple,
                    ),
                    title: Text("Join Us as a Tutor",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    onTap: () {},
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
                    onTap: () {},
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
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    bodyView() {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Colors.white,
            child: containerElement(),
          ),
        ),
      );
    }

    return bodyView();
  }
}
