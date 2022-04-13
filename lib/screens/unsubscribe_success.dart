import 'package:eventsmangers2/screens/event_details.dart';
import 'package:flutter/material.dart';

class UnSubscribeSuccess extends StatefulWidget {
  const UnSubscribeSuccess({Key? key}) : super(key: key);

  @override
  State<UnSubscribeSuccess> createState() => _UnSubscribeSuccessState();
}

class _UnSubscribeSuccessState extends State<UnSubscribeSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("Successfully unsubscribed"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 100,),
            SizedBox(height: 30,),
            Container(
              child: Text("Successfully unsubscribed", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(width: 3, color: Colors.brown),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },

              child: Text(
                "Back",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
