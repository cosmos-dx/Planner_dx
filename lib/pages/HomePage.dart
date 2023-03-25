import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:planner_app/Customs/TodoCard.dart';
import 'package:planner_app/Service/Auth_Service.dart';
import 'package:planner_app/pages/AddToDo.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/pages/ChatmeGpt.dart';
import 'package:planner_app/pages/SignUPPage.dart';
import 'package:planner_app/pages/meet.dart';
import 'package:planner_app/pages/profilepage.dart';
import 'package:planner_app/pages/view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? toidfin = "";
  String? idof;
  String today = "";
  bool myvalcheck = false;
  // final Stream<QuerySnapshot> _stream =
  //     FirebaseFirestore.instance.collection("ToDo").snapshots();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    switch (date.weekday) {
      case 1:
        today = "Monday";
        break;
      case 2:
        today = "Tuesday";
        break;
      case 3:
        today = "Wednesday";
        break;
      case 4:
        today = "Thursday";
        break;
      case 5:
        today = "Friday";
        break;
      case 6:
        today = "Saturday";
        break;
      case 7:
        today = "Sunday";
        break;
    }
    today = "    This  " + today;

    String collect = "ToDo${auth.currentUser?.uid}";
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Profile()));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text(
                  today,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ChatPage()));
              },
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Colors.indigoAccent,
                    Colors.purple,
                  ])),
              child: InkWell(
                onTap: () {
                  print(auth.currentUser);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => AddTodoPage()),
                      (route) => false);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                webViewMethodForMic();
                WebViewMethodForCamera();
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => MeetingPage()));
              },
              child: Icon(
                Icons.meeting_room,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.white,
            label: '',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(collect).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    IconData iconData;
                    Color iconColor;
                    Map<String, dynamic?> document = snapshot.data?.docs[index]
                        .data() as Map<String, dynamic?>;
                    idof = snapshot.data?.docs[index].id;
                    toidfin = idof;
                    switch (document["Category"]) {
                      case "Food":
                        iconColor = Colors.red;
                        iconData = Icons.restaurant;
                        break;
                      case "Work":
                        iconColor = Colors.green;
                        iconData = Icons.work;
                        break;
                      case "WorkOut":
                        iconColor = Colors.blue;
                        iconData = Icons.sports_gymnastics;
                        break;

                      case "Design":
                        iconColor = Colors.amber;
                        iconData = Icons.cottage_outlined;
                        break;

                      case "Run":
                        iconColor = Colors.teal;
                        iconData = Icons.run_circle;
                        break;

                      default:
                        iconColor = Colors.white;
                        iconData = Icons.alarm_add_outlined;
                    }

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => ViewData(
                              document: document,
                              id: snapshot.data?.docs[index].id,
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        setState(() {
                          myvalcheck = !myvalcheck;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        child: TodoCard(
                          title: document['title'] == null
                              ? "Title Was Not Mentioned"
                              : document['title'],
                          check: myvalcheck,
                          iconBgColor: Colors.white,
                          iconColor: iconColor,
                          iconData: iconData,
                          time: document['tmpstmp'],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        String temp = "ToDo${auth.currentUser?.uid}";
        FirebaseFirestore.instance.collection(temp).doc(idof).delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("You want to delete this task ?"),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future webViewMethodForMic() async {
    print('In Microphone permission method');
    //WidgetsFlutterBinding.ensureInitialized();

    await Permission.microphone.request();
    WebViewMethodForCamera();
  }

  Future WebViewMethodForCamera() async {
    print('In Camera permission method');
    //WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
  }
}

// IconButton(
//           icon: Icon(Icons.logout),
//           onPressed: () async {
//             await authClass.logout(context);
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (builder) => SignUpPage()),
//                 (route) => false);
//           },
//         )
