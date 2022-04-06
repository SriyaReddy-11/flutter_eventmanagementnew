 import 'dart:async';

import 'package:eventsmangers2/services/databases.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {


  DatabaseService _dbService = DatabaseService();

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController=controller;
  }

  final _formKey = GlobalKey<FormState>();
  String imageError = '';

  List images = [];
  Image? image;
  File? _image;
  final eventnameController = TextEditingController();
  final descriptionController = TextEditingController();

  late DateTime date;

  bool loading = false;
  final picker = ImagePicker();
  String? imgString;
  Future<File>? imgFile;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }
  @override
  Widget build(BuildContext context) {

    print(_image);
    // final cpassController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("Add Events"),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Create Event", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: _image != null ? Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 40, 14.0, 40),
                        child: Image.file(_image!, fit: BoxFit.contain),
                      ) : OutlineButton(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.8), width: 1.0),
                        onPressed: () {
                          getImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 40, 14.0, 40),
                          child: Icon(Icons.add, color: Colors.grey,),
                        ),

                      ),
                    ),
                  ),


                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField (
                        controller: eventnameController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(

                            border: InputBorder.none,
                            labelText: 'Enter Event Name',
                            hintText: 'Enter event name',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),

                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                              color: Colors.white,
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
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      Row(
                        children: [
                          Text("Event Date:", style: TextStyle(color: Colors.white, fontSize: 15),),
                          SizedBox(width: 10,),
                          ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text(date.toString(), style: TextStyle(color: Colors.black),),
                            ),
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2030, 6, 7),
                                  onChanged: (date) {
                                    print('change $date');
                                  },
                                  onConfirm: (datepicked) {
                                    print('confirm $datepicked');
                                    setState(() {
                                      date = datepicked;
                                    });
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
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
                      SizedBox(height: 10,),
                      // Row(
                      //   children: [
                      //     Text("Event Location:", style: TextStyle(color: Colors.white, fontSize: 15),),
                      //     SizedBox(width: 10,),
                      //     ElevatedButton(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 8.0, right: 8),
                      //         child: Text("Tap to enter location", style: TextStyle(color: Colors.black),),
                      //       ),
                      //       onPressed: () {
                      //         showModalBottomSheet(
                      //             context: context,
                      //             builder: (context) {
                      //               return GoogleMap(
                      //                 onMapCreated: _onMapCreated,
                      //                 initialCameraPosition: CameraPosition(
                      //                   target: _center,
                      //                   zoom: 11.0,
                      //                 ),
                      //               );
                      //             });
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //           primary: Colors.white,
                      //           padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      //           textStyle: TextStyle(
                      //               fontSize: 20,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold)),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("Submit", style: TextStyle(color: Colors.black),),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            if(_image != null){
                              String imageUrl;
                              final FirebaseStorage storage = FirebaseStorage.instance;

                              final String image= "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
                              StorageUploadTask task = storage.ref().child(image).putFile(_image);

                              StorageTaskSnapshot snapshot1 = await task.onComplete.then((snapshot) => snapshot);

                              task.onComplete.then((snapshot3) async {
                                imageUrl = await snapshot1.ref.getDownloadURL();
                                try{
                                  print("adding event to database....");
                                  await _dbService.AddEvents(eventnameController.text, descriptionController.text, imageUrl, "events", "60", "484", date);

                                }catch(e){
                                  print("we had an error");
                                  print(e.toString());
                                }
                                setState(() {
                                  loading = false;
                                });
                              });
                            }
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
              )

          ],
          ),
        ),
      ),
    );
  }
}
