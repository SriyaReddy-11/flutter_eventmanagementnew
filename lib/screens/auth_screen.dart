
import 'package:eventsmangers2/screens/customer_login.dart';
import 'package:eventsmangers2/screens/organizer_login.dart';
import 'package:eventsmangers2/screens/register.dart';
import 'package:flutter/material.dart';


class AuthScreens extends StatefulWidget {
  const AuthScreens({Key? key}) : super(key: key);

  @override
  _AuthScreensState createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  bool show_customer = true;
  final isSelected = <bool>[true, false];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(

            children: [
              show_customer? Text('Customer Login', style: TextStyle(fontSize: 20,color: Colors.white),):
                    Text('Event Organizer', style: TextStyle(fontSize: 20,color: Colors.white),),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          elevation: 6,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                          backgroundColor: show_customer? Colors.blueAccent: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: show_customer? const Text(
                        'Customer',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ): const Text(
                          'Customer',
                          style: TextStyle(fontSize: 24, color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          show_customer = true;
                        });
                      },
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          elevation: 6,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          backgroundColor: show_customer? Colors.blueAccent: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: show_customer? const Text(
                        'Organizer',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ): const Text(
                          'Organizer',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          show_customer = false;
                        });

                      },
                    )
                  ],
                ),
              ),

              Container(

                child: show_customer? CustomerLoginScreen(): OrganizerLoginScreen()
              ),
            ],
          ),
        ),
      ),
    );

  }
}
