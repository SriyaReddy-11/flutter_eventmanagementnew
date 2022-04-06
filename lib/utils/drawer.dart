import 'dart:math';
import 'package:eventsmangers2/models/userData.dart';
import 'package:eventsmangers2/screens/create_event.dart';
import 'package:eventsmangers2/screens/my_events.dart';
import 'package:eventsmangers2/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  int _selectedDestination = 0;
  final AuthService _auth = AuthService();
  bool is_organizer = false;

  @override
  Widget build(BuildContext context) {
    final user_data= Provider.of<List<UserData>>(context);
    if(user_data.length > 0){
      setState(() {
        is_organizer = user_data[0].is_organizer!;
      });
    }

    return Row(
      children: [
        Drawer(
          child: ListView(

            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              createDrawerHeader(),

              Divider(
                height: 1,
                thickness: 1,
              ),

              is_organizer ? ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text('Ongoing Events'),
                selected: _selectedDestination == 0,
                onTap: () {
                  selectDestination(0);
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllUsers()));
                },
              ): Container(),

              is_organizer ? ListTile(
                leading: Icon(Icons.add),
                title: Text('Create New Events'),
                selected: _selectedDestination == 1,
                onTap: () {
                  selectDestination(1);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateEvent()));
                },
              ): Container(),

              ListTile(
                leading: Icon(Icons.book),
                title: Text('My Events'),
                selected: _selectedDestination == 2,
                onTap: () {
                  selectDestination(2);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyEvents()));
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('New Events'),
                selected: _selectedDestination == 3,
                onTap: () => selectDestination(3),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  leading: Icon(Icons.label),
                  title: Text('Logout'),
                  selected: _selectedDestination == 2,
                  onTap: () async{
                    await _auth.signOut();
                  },
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),

            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),

      ],
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                image:  AssetImage('assets/images/admin_avatar.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 7.0,
              left: 16.0,
              child: Text("User",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900))),
        ]));
  }

}
