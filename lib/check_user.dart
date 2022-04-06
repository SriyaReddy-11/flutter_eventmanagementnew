import 'package:eventsmangers2/models/userData.dart';
import 'package:eventsmangers2/screens/home_screen.dart';
import 'package:eventsmangers2/services/auth.dart';
import 'package:eventsmangers2/wrapper.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    bool is_organizer;
    final AuthService _auth = AuthService();
    final user_data= Provider.of<List<UserData>>(context);
    print(user_data.length);
    if(user_data.length > 0){
      if(user_data[0].is_organizer!){
        setState(() {
          is_organizer = true;
        });
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
      }else{
        // Fluttertoast.showToast(
        //     msg: "This is not an organizer account",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.red,
        //     fontSize: 16.0
        // );
        // _auth.signOut();
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Checking User .....", style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
              CircularProgressIndicator(),

            ],
          )
      ),
    );
  }
}
