import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/screens/event_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class EventsTile extends StatefulWidget {

  EventsTile({Key? key}) : super(key: key);




  @override
  State<EventsTile> createState() => _EventsTileState();
}

class _EventsTileState extends State<EventsTile> {
  @override
  Widget build(BuildContext context) {
    final events_details= Provider.of<List<EventData>>(context);
    return ListTile(
      tileColor: Colors.grey.shade50,
      title: Text(events_details[0].event_name!, style: TextStyle(color: Colors.black),),
      subtitle: Text(events_details[0].event_date!.toString(), style: TextStyle(color: Colors.black)),
      trailing: TextButton(
        child: Text(
          "View Event",
          style: TextStyle(fontSize: 15),
        ),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventsDetails(eventData: events_details[0],)));
        },
      )
    );
  }
}
