import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:planner_app/pages/meet.dart';
import 'package:uuid/uuid.dart';

class genmeetcode extends StatefulWidget {
  genmeetcode({Key? key}) : super(key: key);

  @override
  State<genmeetcode> createState() => _genmeetcodeState();
}

class _genmeetcodeState extends State<genmeetcode> {
  String code = "abcdefg";
  @override
  void initState() {
    // TODO: implement initState
    var uuid = Uuid();
    code = uuid.v1().substring(0, 8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _newmeettextcontroller = TextEditingController();
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
              "https://static.vecteezy.com/system/resources/previews/003/857/433/non_2x/man-working-with-computer-concept-illustration-working-process-freelance-office-work-from-home-business-meeting-via-internet-communication-illustration-free-vector.jpg",
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
                child: InkWell(
                  onLongPress: () async {
                    _newmeettextcontroller.text = code;
                    print("jai=======================");
                    await Clipboard.setData(ClipboardData(text: code));
                    final snackBar = SnackBar(
                      content: const Text('Copied to Clipboard'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text(
                    //controller: _newmeettextcontroller,
                    code,
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1.15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Join"),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(80, 30),
                  primary: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Long Press For create and copy the meet code !")
          ],
        ),
      ),
    );
  }
}
