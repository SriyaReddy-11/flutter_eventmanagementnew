import 'package:eventsmangers2/models/event_subscribers.dart';
import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/user.dart';
import 'package:eventsmangers2/services/databases.dart';
import 'package:eventsmangers2/utils/my_events_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventSubscribers extends StatefulWidget {
  final String? event_id;

  const EventSubscribers({Key? key, this.event_id}) : super(key: key);

  @override
  State<EventSubscribers> createState() => _EventSubscribersState();
}

class _EventSubscribersState extends State<EventSubscribers> {
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
              value:DatabaseService().eventSubscribers(widget.event_id!),
              initialData: [],),
          ],
          child: MyEventsLists()),
    );
  }
}
