import 'package:eventsmangers2/check_user.dart';
import 'package:eventsmangers2/services/auth.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class OrganizerLoginScreen extends StatefulWidget {
  @override
  State<OrganizerLoginScreen> createState() => _OrganizerLoginScreenState();
}

class _OrganizerLoginScreenState extends State<OrganizerLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String errors = '';

  String message = '';

  bool loading = false;
  final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            SizedBox(height: size.height * 0.035),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(

                validator: (String? val) =>
                val!.isEmpty ? 'Please enter email' : null,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: "Organizer Email", focusColor: Colors.white),
                controller: emailController,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                validator: (String? val) =>
                val!.isEmpty ? 'Please enter password' : null,
                decoration: InputDecoration(labelText: "Password"),
                controller: passwordController,
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text(
                "Forgot your password?",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                errors,
                style: TextStyle(
                    color: Color.fromRGBO(216, 181, 58, 1.0),
                    fontSize: 14.0),
              ),
            ),
            SizedBox(height: size.height * 0.035),
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
                  if (_formKey.currentState!.validate()) {
                    var email = emailController.text;
                    var password = passwordController.text;
                    setState(() {
                      message='Please Wait...';
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text).then((value) {
                      setState(() {
                        loading=false;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper()));

                      });



                      // Fluttertoast.showToast(
                      //     msg: "Successfully Logged In",  // message
                      //     toastLength: Toast.LENGTH_SHORT, // length
                      //     gravity: ToastGravity.CENTER,
                      //     textColor: Colors.green
                      //   // location
                      //   // duration
                      // );
                    });

                    if (!result){
                      loading =false;
                      errors = "An error has occured during sign in";
                      // Fluttertoast.showToast(
                      //     msg: "An error has occured",  // message
                      //     toastLength: Toast.LENGTH_SHORT, // length
                      //     gravity: ToastGravity.CENTER,
                      //     textColor: Colors.green
                      //   // location
                      //   // duration
                      // );
                    }

                    //ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You clicked ElevatedButton.'));
                  }
                },

                child: Text(
                  "Submit",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            //   child: GestureDetector(
            //     onTap: () => {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => RegisterScreen()))
            //     },
            //     child: Text(
            //       "Don't Have an Account? Sign up",
            //       style: TextStyle(
            //           fontSize: 12,
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xFF2661FA)),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
