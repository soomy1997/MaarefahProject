import 'package:flutter/material.dart';

void main() {
  runApp(TutorProfile());
}

class TutorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutor profile',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: myTutorProfile(title: 'Tutor Profile'),
    );
  }
}

class myTutorProfile extends StatefulWidget {
  myTutorProfile({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _myTutorProfile createState() => _myTutorProfile();
}

class _myTutorProfile extends State<myTutorProfile> {
  List<Story> _cards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff14213C),
          actions: [
            IconButton(icon: Icon(Icons.close_rounded), onPressed: () => {})
          ],
          title: Text(widget.title),
          leading: Icon(Icons.arrow_back_ios)),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 50,
                  backgroundImage: AssetImage('images/logo.jpg'),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Faizah Saeed',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '     CIS Student Level 10',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildCardListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardListView() {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        itemCount: _cards.length,
        itemExtent: 180.0,
        itemBuilder: (context, index) {
          var item = _cards[index];
          return Card(
            elevation: 10.0,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          item.storyUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    'Details',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Story {
  final String name;
  final String email;
  final String storyUrl;

  Story({this.name, this.storyUrl, this.email});
}
