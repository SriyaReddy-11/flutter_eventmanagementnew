import 'package:eventsmangers2/models/event_subscribers.dart';
import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/user.dart';
import 'package:eventsmangers2/services/databases.dart';
import 'package:eventsmangers2/utils/my_events_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEvents extends StatefulWidget {
  const MyEvents({Key? key}) : super(key: key);

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscribed events"),
      ),
      body:  MultiProvider(
          providers: [
            StreamProvider<List<EventSubscribersData>>.value(
              value:DatabaseService().myEvents(user!.uid),
              initialData: [],),
          ],
          child: MyEventsLists()),
    );
  }
}
