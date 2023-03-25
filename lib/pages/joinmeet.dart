import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:planner_app/pages/final_meet.dart';
import 'package:planner_app/pages/meet.dart';

class meetcode extends StatelessWidget {
  const meetcode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Icon(Icons.arrow_back_ios_new_sharp, size: 35),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => MeetingPage()),
                      (route) => false);
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Image.network(
              "https://e7.pngegg.com/pngimages/849/984/png-clipart-round-table-meeting-meeting-infographic-photography.png",
              height: 250,
              width: 250,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter the meeting code here !!! ",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 156, 218),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Card(
                color: Color.fromARGB(255, 243, 242, 242),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 1,
                child: TextField(
                  controller: _textcontroller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Example : cosmos_dx"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => finalmeet(
                              channelName: _textcontroller.text.trim(),
                            )),
                    (route) => false);
              },
              child: Text("Join"),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(80, 30),
                  primary: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
