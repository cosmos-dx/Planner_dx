import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:planner_app/Service/Auth_Service.dart';
import 'package:planner_app/pages/AddToDo.dart';
import 'package:planner_app/pages/HomePage.dart';
import 'package:planner_app/pages/SignUPPage.dart';
import 'package:planner_app/pages/SignINPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  // void signup() async {
  //   try {
  //     await firebaseAuth.createUserWithEmailAndPassword(
  //         email: "me.abhi.deo.18@gmail.com", password: "123456");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}
