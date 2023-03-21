import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/Service/Auth_Service.dart';
import 'dart:math';

import 'HomePage.dart';

class ViewData extends StatefulWidget {
  ViewData({Key? key, required this.document, required this.id})
      : super(key: key);
  final Map<String, dynamic?> document;
  final String? id;

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late TextEditingController _titletask;
  late TextEditingController _decriptioncontroller;
  AuthClass _authClass = AuthClass();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String type = "";
  String temp = "";
  String category = "";
  bool edit = false;

  @override
  void initState() {
    super.initState();
    _titletask = TextEditingController(text: widget.document['title']);
    _decriptioncontroller =
        TextEditingController(text: widget.document['description']);
    type = widget.document['task'];
    category = widget.document['Category'];
  }

  @override
  Widget build(BuildContext context) {
    final widthi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff252041),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                            (route) => false);
                      },
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => HomePage()),
                                (route) => false);
                          },
                          child: InkWell(
                            onTap: () {
                              showAlertDialog(context);
                            },
                            child: Icon(
                              Icons.delete,
                              color: edit ? Colors.red : Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => HomePage()),
                                (route) => false);
                          },
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                edit = !edit;
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              color: edit ? Colors.green : Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? "Editing" : "Your",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Created Task",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    text_label("Title Info"),
                    SizedBox(
                      height: 12,
                    ),
                    textItem("Task Title", _titletask, false),
                    SizedBox(
                      height: 30,
                    ),
                    text_label("Task Type"),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        chidData("Important", false),
                        SizedBox(
                          width: 20,
                        ),
                        chidData("Planned", false),
                        SizedBox(
                          width: 20,
                        ),
                        chidData("Creative", false),
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    text_label("Description"),
                    SizedBox(
                      height: 10,
                    ),
                    description(
                        "Brief your Task", _decriptioncontroller, false),
                    SizedBox(
                      height: 30,
                    ),
                    text_label(
                      "Category",
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        chidData("Food", true),
                        SizedBox(
                          width: 20,
                        ),
                        chidData("WorkOut", true),
                        SizedBox(
                          width: 20,
                        ),
                        chidData("Work", true),
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        chidData("Design", true),
                        SizedBox(
                          width: 20,
                        ),
                        chidData("Run", true),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    edit ? buttontodo(context) : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget chidData(String chiptext, bool flag) {
    return InkWell(
      onTap: edit
          ? () {
              if (flag == false) {
                setState(() {
                  type = chiptext;
                });
              } else {
                setState(() {
                  category = chiptext;
                });
              }
            }
          : null,
      child: Chip(
        backgroundColor: type == chiptext
            ? Color.fromARGB(255, 255, 255, 255)
            : category == chiptext
                ? Color.fromARGB(255, 255, 255, 255)
                : getRandomColor(flag),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          chiptext,
          style: TextStyle(
            color: type == chiptext
                ? Color.fromARGB(255, 56, 54, 54)
                : category == chiptext
                    ? Color.fromARGB(255, 56, 54, 54)
                    : Colors.white,
            fontSize: type == chiptext
                ? 13
                : category == chiptext
                    ? 13
                    : 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget textItem(
      String labeltext, TextEditingController controller, bool obsecuretext) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: edit ? 55 : 85,
      child: TextFormField(
        controller: _titletask,
        enabled: edit,
        obscureText: obsecuretext,
        style: TextStyle(
          fontSize: edit ? 17 : 22,
          color: Colors.white,
        ),
        maxLines: null,
        decoration: InputDecoration(
          labelText: edit ? labeltext : "",
          contentPadding:
              edit ? EdgeInsets.only(left: 20) : EdgeInsets.only(left: 20),
          labelStyle: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 214, 214, 214),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 19, 255, 7),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        temp = "ToDo${auth.currentUser?.uid}";
        FirebaseFirestore.instance.collection(temp).doc(widget.id).delete();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomePage()),
            (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("You really want to delete ?"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget description(
      String labeltext, TextEditingController controller, bool obsecuretext) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 185,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _decriptioncontroller,
        enabled: edit,
        obscureText: obsecuretext,
        style: TextStyle(
          fontSize: 17,
          color: Colors.grey,
        ),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: labeltext,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget text_label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.5,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget buttontodo(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_titletask.text.isEmpty ||
            _decriptioncontroller.text.isEmpty ||
            type.isEmpty ||
            category.isEmpty) {
          showSnackBar(context, "Empty Field Not Allowed");
        } else {
          temp = "ToDo${auth.currentUser?.uid}";
          FirebaseFirestore.instance.collection(temp).doc(widget.id).update({
            "title": _titletask.text,
            "Category": category,
            "description": _decriptioncontroller.text,
            "task": type
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        }
        showSnackBar(context, "Task Added to Planner");
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: Center(
          child: Text(
            "Update Task",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Color getRandomColor(bool flag) {
    if (flag) {
      Random random = new Random();
      int r = random.nextInt(100);
      int g = random.nextInt(256);
      int b = random.nextInt(256);
      return Color.fromARGB(255, 255, g, b);
    } else {
      Random random = new Random();
      int r = random.nextInt(100);
      int g = random.nextInt(256);
      int b = random.nextInt(256);
      return Color.fromARGB(255, r, g, b);
    }
  }

  void showSnackBar(BuildContext context, String texti) {
    final snackBar = SnackBar(content: Text(texti));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
