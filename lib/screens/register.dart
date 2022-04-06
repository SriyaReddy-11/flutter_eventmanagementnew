
import 'package:eventsmangers2/services/auth.dart';
import 'package:eventsmangers2/wrapper.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final cpassController = TextEditingController();

  String errors = '';

  String message = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: GestureDetector(
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
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Customer SignUp ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Text(errors, style: TextStyle(fontSize: 10, color: Colors.red),),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: nameController,
                    validator: (String? val) =>
                    val!.isEmpty ? 'Please Enter Name' : null,
                    decoration: InputDecoration(labelText: "Name"),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: emailController,
                    validator: (String? val) =>
                    val!.isEmpty ? 'Email cannot be Empty' : null,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (String? val) =>
                    val!.isEmpty ? 'Password Cannot be Empty' : null,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: cpassController,
                    validator: (String? val) => val != passwordController.text
                        ? 'Password Did not Match'
                        : null,
                    decoration:
                    InputDecoration(labelText: "Confirm Password"),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                loading ? CircularProgressIndicator(): Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        try {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(
                              emailController.text, nameController.text,
                              phoneController.text, false,
                              passwordController.text).then((value) {

                          }).then((value){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => Wrapper()));
                          });
                          print(result);
                          }  on PlatformException catch (e) {
                          setState(() {
                            loading = false;
                            errors = e.toString();
                          });
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.black,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 30.0,
                      width: size.width * 0.5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(0.0),
                          color: Colors.white,),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "Create Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                //               builder: (context) => LoginScreen()))
                //     },
                //     child: Text(
                //       "Already Have an Account? Sign in",
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
        ),
      ),
    );
  }
}
