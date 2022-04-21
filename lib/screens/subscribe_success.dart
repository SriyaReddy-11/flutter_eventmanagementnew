import 'package:flutter/material.dart';

class SubscribeSuccess extends StatefulWidget {
  const SubscribeSuccess({Key? key}) : super(key: key);

  @override
  State<SubscribeSuccess> createState() => _SubscribeSuccessState();
}

class _SubscribeSuccessState extends State<SubscribeSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("Successfully subscribed"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 100,),
            SizedBox(height: 30,),
            Container(
              child: Text("Successfully subscribed", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
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
