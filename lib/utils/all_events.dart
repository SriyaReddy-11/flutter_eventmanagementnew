import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/userData.dart';
import 'package:eventsmangers2/screens/event_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventsLists extends StatefulWidget {
  const EventsLists({Key? key}) : super(key: key);

  @override
  _EventsListsState createState() => _EventsListsState();
}

class _EventsListsState extends State<EventsLists> {
  @override
  Widget build(BuildContext context) {
    final events= Provider.of<List<EventData>>(context);
    // final users= Provider.of<List<UserData>>(context);
    return ListView.builder(
      itemBuilder:(context, index){

        return InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventsDetails(eventData: events[index],)));
          },
          child: Card(

            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(

                  title: Text(events[index].event_name!, style: TextStyle(color: Colors.black),),
                  subtitle: Text(events[index].event_date!.toString(), style: TextStyle(color: Colors.black)),
                ),
                Container(
                  margin:EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: InkWell(
                      onTap: () => print("ciao"),
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            // child: Image.asset(
                            //     'img/britannia.jpg',
                            //     width: 300,
                            //     height: 150,
                            //     fit:BoxFit.fill
                            //
                            // ),
                            child:Image.network(events[index].photo_url!,  width: 300,
                                height: 250,
                                fit:BoxFit.fill),
                          ),
                          ListTile(
                            title: Text(events[index].event_description!),

                          ),
                        ],
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        );
      },
      itemCount: events.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
    );
  }
}
