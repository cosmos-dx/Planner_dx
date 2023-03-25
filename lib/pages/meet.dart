import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:planner_app/pages/createmeet.dart';
import 'package:planner_app/pages/joinmeet.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Set Your Meeting Here !"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => genmeetcode()));
              },
              icon: Icon(Icons.add),
              label: Text("New Meeting"),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 30),
                  primary: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
            ),
          ),
          Divider(
            thickness: 1,
            height: 40,
            indent: 40,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => meetcode()));
              },
              icon: Icon(Icons.margin),
              label: Text("Join with a meeting code"),
              style: OutlinedButton.styleFrom(
                primary: Colors.indigo,
                fixedSize: Size(350, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 7,
          ),
          Image.network(
              "https://empmonitor.com/blog/wp-content/uploads/2021/12/Untitled-design23-1280x640.png"),
        ],
      ),
    );
  }
}
