import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventsmangers2/models/event_subscribers.dart';
import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/userData.dart';
import 'package:eventsmangers2/screens/event_details.dart';
import 'package:eventsmangers2/services/databases.dart';
import 'package:eventsmangers2/utils/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyEventsLists extends StatefulWidget {
  const MyEventsLists({Key? key}) : super(key: key);

  @override
  _MyEventsListsState createState() => _MyEventsListsState();
}

class _MyEventsListsState extends State<MyEventsLists> {
  @override
  Widget build(BuildContext context) {

    // final users= Provider.of<List<UserData>>(context);
    final my_events= Provider.of<List<EventSubscribersData>>(context);
    return ListView.builder(
      itemBuilder:(context, index){

        return MultiProvider(
          providers: [
            StreamProvider<List<EventData>>.value(
              value:DatabaseService().eventsById(my_events[index].event_id!),
              initialData: [],),
          ],
          child: EventsTile(),
        );
      },
      itemCount: my_events.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
    );
  }
}
