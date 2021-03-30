import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app_1/utils/constants.dart';

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
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, bottom: 5, top: 5),
              child: Text(
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series"
                "Newton formulae can be obtained by manipulating Taylor series",
                textAlign: TextAlign.justify,
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
              FaIcon(
                FontAwesomeIcons.twitter,
              ),
              FaIcon(FontAwesomeIcons.instagram),
              FaIcon(FontAwesomeIcons.youtube),
              FaIcon(FontAwesomeIcons.facebook),
              FaIcon(FontAwesomeIcons.linkedin),
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
