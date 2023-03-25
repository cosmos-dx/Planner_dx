import 'dart:convert';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:wakelock/wakelock.dart';

class finalmeet extends StatefulWidget {
  String channelName = "plan";

  finalmeet({required this.channelName});
  @override
  State<finalmeet> createState() => _finalmeetState();
}

class _finalmeetState extends State<finalmeet> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final AgoraClient client;
  bool _loading = true;
  String temptoken = "";

  Future<void> getToken() async {
    String link = "YourTokenServer${widget.channelName}";
    Response _response = await get(Uri.parse(link));
    Map data = jsonDecode(_response.body);
    setState(() {
      temptoken = data["token"];
    });

    client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
            appId: "App_Id",
            tempToken: temptoken,
            channelName: widget.channelName,
            username: auth.currentUser?.uid),
        enabledPermission: [Permission.camera, Permission.microphone]);

    await client.initialize();
    Future.delayed(Duration(seconds: 3))
        .then((value) => setState(() => _loading = false));
  }

  @override
  void initState() {
    getToken();

    super.initState();
    //initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  AgoraVideoViewer(
                    client: client,
                    //layoutType: Layout.floating,
                  ),
                  AgoraVideoButtons(client: client)
                ],
              ),
      ),
    );
  }
}
