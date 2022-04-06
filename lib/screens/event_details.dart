import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/user.dart';
import 'package:eventsmangers2/screens/subscribe_success.dart';
import 'package:eventsmangers2/services/databases.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventsDetails extends StatefulWidget {
  final EventData? eventData;

  const EventsDetails({Key? key, this.eventData}) : super(key: key);


  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  DatabaseService _dbService = DatabaseService();



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(widget.eventData!.event_name!, style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
              ),
              Image.network(widget.eventData!.photo_url!),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(widget.eventData!.event_description!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up_sharp,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.thumb_down,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () {},
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () {},
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.subdirectory_arrow_left,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () {},
                    ),


                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(width: 3, color: Colors.brown),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () async {
                    await _dbService.AddSubscribers(user!.uid, widget.eventData!.event_id!).then((value) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubscribeSuccess()));
                    });
                  },

                  child: Text(
                    "Subscribe",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),

            ],
          )),
    );
  }
}
