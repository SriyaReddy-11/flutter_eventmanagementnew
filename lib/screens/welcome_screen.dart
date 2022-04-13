import 'dart:async';

import 'package:eventsmangers2/wrapper.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Wrapper())));
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 148.0),
          child: Column(


            children: [
              Image.asset("assets/images/welcome.png", height: 150, width: 150,),
              SizedBox(height: 50,),
              Text("Events Management", style: TextStyle(color: Colors.white, fontSize: 30),)

            ],
          ),
        ),
      ),
    );
  }
}
