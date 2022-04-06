'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/user.dart';
import 'package:eventsmangers2/models/userData.dart';
import 'package:eventsmangers2/services/auth.dart';
import 'package:eventsmangers2/services/databases.dart';
import 'package:eventsmangers2/utils/all_events.dart';
import 'package:eventsmangers2/utils/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override

  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return Scaffold(
      backgroundColor: Colors.indigo,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
            onPressed: () async{
              _auth.signOut().then((value) {
                // Fluttertoast.showToast(
                //     msg: "Successfully Logged Out",  // message
                //     toastLength: Toast.LENGTH_SHORT, // length
                //     gravity: ToastGravity.CENTER,
                //   textColor: Colors.black
                //   // location
                //                // duration
                // );
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: MultiProvider(
          providers: [
            StreamProvider<List<EventData>>.value(
              value:DatabaseService().allEvents(),
              initialData: [],),

            StreamProvider<List<UserData>>.value(
              initialData: [],
              value: DatabaseService().usersById(user!.uid),
            ),
          ],
          child: EventsLists())
    );
  }
}
