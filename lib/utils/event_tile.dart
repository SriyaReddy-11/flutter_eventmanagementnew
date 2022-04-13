import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventsmangers2/models/event_subscribers.dart';
import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/userData.dart';
import 'package:eventsmangers2/screens/event_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class EventsTile extends StatefulWidget {
  final bool accepted;
  final bool rejected;
  final String id;
  const EventsTile({Key? key, required this.accepted,required this.rejected, required this.id}) : super(key: key);





  @override
  State<EventsTile> createState() => _EventsTileState();
}

class _EventsTileState extends State<EventsTile> {
  @override
  Widget build(BuildContext context) {
    bool accepted = widget.accepted;
    final events_details= Provider.of<List<EventData>>(context);
    final my_events= Provider.of<List<EventSubscribersData>>(context);
    final user= Provider.of<List<UserData>>(context);
    if(my_events == null){
      return Container(
        child: Text("Event has no subscribers"),
      );
    }else{
      return InkWell(
        onTap: (){
          user[0].is_organizer!? showModalBottomSheet(
              context: context,
              builder: (context){
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding:  EdgeInsets.all(32.0),
                          child:  Column(
                            children: <Widget>[
                              Text("Confirm"),
                              RaisedButton(onPressed: () async{
                                await Firestore.instance.collection("eventSubscribers").document(widget.id).updateData({
                                  "accepted": true,
                                  "rejected": false

                                }).then((value) => Navigator.pop(context));
                              },
                                child:  Text("Confirm", style: TextStyle(color: Colors.green)),)
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding:  EdgeInsets.all(32.0),
                          child:  Column(
                            children: <Widget>[
                              Text("Reject"),
                              RaisedButton(onPressed: () async{
                                await Firestore.instance.collection("eventSubscribers").document(widget.id).updateData({
                                  "accepted": false,
                                  "rejected": true

                                }).then((value) => Navigator.pop(context));
                              },
                                child:  Text("Reject", style: TextStyle(color: Colors.red)),)
                            ],
                          ),
                        ),

                        Container(
                          padding:  EdgeInsets.all(32.0),
                          child:  Column(
                            children: <Widget>[
                              Text("View"),
                              RaisedButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventsDetails(eventData: events_details[0], userData: user[0],)));
                              }, child:  Text("View", style: TextStyle(color: Colors.black),),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }):Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventsDetails(eventData: events_details[0], userData: user[0],)));

        },
        child: user[0].is_organizer! ? ListTile(
            tileColor: Colors.grey.shade50,
            title: Text(events_details[0].event_name!, style: TextStyle(color: Colors.black),),
            subtitle: Text(events_details[0].event_date!.toString(), style: TextStyle(color: Colors.black)),
            trailing:accepted?Text("Confirmed (Tap for more Actions)", style: TextStyle(color: Colors.green, fontSize: 14)):
            widget.rejected? Text("Rejected(Tap for more Actions)", style: TextStyle(color: Colors.red, fontSize: 14),):
            Text("Pending (Tap for more Actions)", style: TextStyle(color: Colors.grey, fontSize: 16))
        ):ListTile(
            tileColor: Colors.grey.shade50,
            title: Text(events_details[0].event_name!, style: TextStyle(color: Colors.black),),
            subtitle: Text(events_details[0].event_date!.toString(), style: TextStyle(color: Colors.black)),
            trailing: widget.rejected ?Text("Rejected", style: TextStyle(fontSize: 15, color: Colors.red),):
            accepted? Text("Accepted", style: TextStyle(color: Colors.green, fontSize: 10),):
            Text("Pending (Tap to view event)", style: TextStyle(color: Colors.grey, fontSize: 16))
        ),
      );
    }

  }
}

