import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventsmangers2/models/event_subscribers.dart';
import 'package:eventsmangers2/models/eventsData.dart';
import 'package:eventsmangers2/models/user.dart';
import 'package:eventsmangers2/models/userData.dart';
import 'package:eventsmangers2/screens/event_subscribers.dart';
import 'package:eventsmangers2/screens/subscribe_success.dart';
import 'package:eventsmangers2/screens/unsubscribe_success.dart';
import 'package:eventsmangers2/services/databases.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class EventsDetails extends StatefulWidget {
  final EventData? eventData;
  final UserData? userData;

  const EventsDetails({Key? key, this.eventData, this.userData}) : super(key: key);


  @override
  State<EventsDetails> createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  DatabaseService _dbService = DatabaseService();

  TextEditingController eventnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool loading = false;



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(widget.userData!.is_organizer!);
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
                        Icons.share,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () {

                        Fluttertoast.showToast(
                            msg: "Event shared successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                    ),

                    widget.userData!.is_organizer! ?IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () {
                        setState(() {
                          eventnameController.text =   widget.eventData!.event_name!;
                          descriptionController.text =   widget.eventData!.event_description!;
                        });
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Edit the event using the form below", style: TextStyle(color: Colors.black, fontSize: 20),),
                                      ),
                                      TextFormField (
                                        controller: eventnameController,
                                        keyboardType: TextInputType.multiline,

                                        decoration: InputDecoration(

                                          border: InputBorder.none,

                                          labelText: 'Enter Event Name',
                                          hintText: 'Enter event name',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                          ),

                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      TextFormField (
                                        controller: descriptionController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        decoration: InputDecoration(

                                          border: InputBorder.none,
                                          labelText: 'Enter Description',
                                          hintText: 'Event description',
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20,),


                                      loading? CircularProgressIndicator(): ElevatedButton(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                                          child: Text("Edit", style: TextStyle(color: Colors.black),),
                                        ),
                                        onPressed: () async {
                                          if(_formKey.currentState!.validate()) {
                                            setState(() {
                                              loading = true;
                                            });
                                            await Firestore.instance.collection("events").document(widget.eventData!.event_id).updateData({
                                              "event_name": eventnameController.text,
                                              "event_description": descriptionController.text,

                                            }).then((value) {
                                              Navigator.pop(context);
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),

                                    ],
                                  ),
                                ),
                              );

                            });
                      },
                    ): Container(),
                    widget.userData!.is_organizer! ?IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () async {
                        await Firestore.instance.collection("events").document(widget.eventData!.event_id).delete().then((value) {
                          Navigator.pop(context);
                        });
                      },
                    ): IconButton(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      iconSize: 50,
                      color: Colors.black,
                      splashColor: Colors.purple,
                      onPressed: () {
                        //Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Event Liked ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                    ),



                  ],
                ),
              ),

              widget.userData!.is_organizer! ?  MultiProvider(
                providers: [
                  StreamProvider<List<EventSubscribersData>>.value(
                    value:DatabaseService().myEvents(user!.uid),
                    initialData: [],
                  ),
                ],
                child:Container(
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

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventSubscribers(event_id: widget.eventData!.event_id,)));

                    },

                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "View Event Subscribers",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),


                )):
                  MultiProvider(
                    providers: [
                      StreamProvider<List<EventSubscribersData>>.value(
                        value:DatabaseService().myEvents(user!.uid),
                        initialData: [],
                      ),
                    ],
                      child: SubscribeButton(event_id: widget.eventData!.event_id,))
            ]
          )
    ));

  }
}


class SubscribeButton extends StatefulWidget {
  final String? event_id;

  const SubscribeButton({Key? key, this.event_id}) : super(key: key);


  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {

  bool subscribed = false;
  String subscribe_id = "";
  DatabaseService _dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    final subscribed_events= Provider.of<List<EventSubscribersData>>(context);

    for(var event in subscribed_events){
      print("${event.event_id}");
      if(event.event_id == widget.event_id){

        setState(() {
          subscribe_id = event.subscription_id!;
          subscribed = true;
        });
        break;
      }
    }
    return subscribed? Container(
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
          await Firestore.instance.collection("eventSubscribers").document(subscribe_id).delete().then((value) {
           print("subscription deleted");
           setState(() {
             // subscribe_id = event.subscription_id!;
             subscribed = false;
           });
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => UnSubscribeSuccess()));
          });
        },

        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Unsubscribe",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),


    ): Container(
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
          await _dbService.AddSubscribers(user!.uid, widget.event_id!).then((value) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubscribeSuccess()));
          });
        },

        child: Text(
          "Subscribe",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),


    );
  }
}
