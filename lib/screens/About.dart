import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app_1/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    customContainer() {
      return Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 3),
              child: Text(
                "The Ma’arefah application is a proposed solution to support the initiative that is organized by the College of Computer and Information Technology at IAU to assist male and female students in their various academic levels.                                              "
                "It aims to increase their academic achievement,   in addition to making the application run through the electronic process instead of the traditional ones.",
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.normal, height: 2),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Follow us ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () {
                    const url = "https://mobile.twitter.com/MaarefahApp";
                    if (canLaunch(url) != null) launch(url);
                  }),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram),
                  onPressed: () {
                    const url = "https://www.instagram.com/maarefahapp/";
                    if (canLaunch(url) != null) launch(url);
                  }),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.youtube),
                  onPressed: () {
                    const url =
                        "https://www.youtube.com/channel/UCMl7a2CXPkVK-j29p6LIaUg";
                    if (canLaunch(url) != null) launch(url);
                  }),
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebook),
                  onPressed: () {
                    const url =
                        "https://m.facebook.com/maarefah.app.5?mds=%2Ftimeline%2Fcover%2Fdialog%2F%3Fredirect_uri%3D%252Fmaarefah.app.5%253Flst%253D100065960108477%25253A100065960108477%25253A1617848348";
                    if (canLaunch(url) != null) launch(url);
                  }),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: myAppBar2(
        context,
        title: 'About Us!',
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Center(child: customContainer()),
          ),
        ],
      ),
    );
  }
}
