import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

final auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SignUp",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: emailContoller,
            decoration: InputDecoration(hintText: "Enter email"),
          ),
          SizedBox(height: 15),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            controller: passwordContoller,
            decoration: InputDecoration(hintText: "Enter password"),
          ),
          MaterialButton(
              color: Colors.blueGrey,
              child: Text("SignUp"),
              onPressed: () async {
                try {
                  final newUser = await auth.createUserWithEmailAndPassword(
                      email: emailContoller.text,
                      password: passwordContoller.text);
                  if (newUser != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MyHomePage()));
                  }
                } catch (e) {
                  print(e.toString());
                }
              })
        ],
      ),
    );
  }
}
