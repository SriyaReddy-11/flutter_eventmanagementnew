import 'package:eventsmangers2/check_user.dart';
import 'package:eventsmangers2/screens/auth_screen.dart';
import 'package:eventsmangers2/screens/home_screen.dart';
import 'package:eventsmangers2/services/databases.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'models/user.dart';
import 'models/userData.dart';

class Wrapper extends StatefulWidget {

  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print("user id");

    // Return home or authenticate widget
    if(user == null){
      return AuthScreens();

    }else{
      return MultiProvider(
          providers: [
            StreamProvider<List<UserData>>.value(
              initialData: [],
              value: DatabaseService().usersById(user.uid),
            ),

          ],
          child: HomePage()

      );
    }

  }
}
