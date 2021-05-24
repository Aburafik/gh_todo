import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home_page.dart';

final auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  bool isregistrining = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isregistrining,
        child: Column(
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
                  setState(() {
                    isregistrining = true;
                  });
                  try {
                    final newUser = await auth.createUserWithEmailAndPassword(
                        email: emailContoller.text,
                        password: passwordContoller.text);
                    if (newUser != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MyHomePage(
                                    userID: newUser.user.uid,
                                  )));
                      setState(() {
                        isregistrining = false;
                      });
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Text(
                          e.message,
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text("Exception!"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"))
                        ],
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
