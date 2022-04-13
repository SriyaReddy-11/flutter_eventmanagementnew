
import 'package:eventsmangers2/screens/auth_screen.dart';
import 'package:eventsmangers2/services/auth.dart';
import 'package:eventsmangers2/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: MyUser.initialData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomeScreen()
      ),
    );
  }
}
