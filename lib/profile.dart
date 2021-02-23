import 'package:flutter/material.dart';
import 'package:flutter_app_1/contact_us.dart';
import 'About.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    TextStyle appBarTitleStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

    elevatedButton() {
      return RaisedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.login),
        label: Text("Sign Out"),
        color: Colors.grey[300],
      );
    }

    var _selectedIndex = 0;
    onItemPressed(index) {
      if (index != _selectedIndex) {
        setState(() => _selectedIndex = index);
      }
    }

    containerElement() {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              custom(),
              SizedBox(
                height: 20,
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
                      Icons.ad_units,
                      color: Colors.orange,
                    ),
                    title: Text("Registered Session",
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
                    title: Text("Join Us as a tutor Session",
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
                      color: Colors.amber,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  elevatedButton(),
                ],
              ),
            ],
          ),
        ),
      );
    }

    bodyView() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Tutors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.military_tech_outlined),
              label: 'Award List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),
          ],
          iconSize: 30,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          onTap: onItemPressed,
        ),
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Color(0xff14213C),
          centerTitle: true,
          title: Text(
            "Profile",
            style: appBarTitleStyle,
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
              onPressed: () {}),
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
    }

    return bodyView();
  }

  custom() {
    SizedBox st = SizedBox(
      height: 5,
    );
    SizedBox spacer = SizedBox(
      height: 15,
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
      "Learner",
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
      height: MediaQuery.of(context).size.height * 0.34,
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
                  backgroundColor: Colors.grey[300],
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gender,
                  acaLevel,
                  email,
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  genderValue,
                  acaValue,
                  emailValue,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
