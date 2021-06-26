import 'package:fire_base_app/home_page.dart';
import 'package:fire_base_app/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final auth = FirebaseAuth.instance;
  String _email;

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Image.asset(
              "images/reset.png",
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Enter the registered email address",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "We will email you a link to reset your password",
                style: TextStyle(color: Colors.grey.shade50),
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                textAlign: TextAlign.center,
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff464450),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(40)),
                  hintText: "Enter email",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: MaterialButton(
                  shape: StadiumBorder(),
                  color: Colors.yellow,
                  child: Text(
                    "SEND",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onPressed: () async {
                    try {
                      await auth.sendPasswordResetEmail(email: _email);
                      resetPasswordMessage(context, _email);

                      //   //////////////
                      // Navigator.pop(context);
                    } catch (e) {
                      print(e.message);
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("Opps}"),
                                content: Text(e.message),
                              ));
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

resetPasswordMessage(BuildContext context, email) {
  AlertDialog alertDialog = AlertDialog(
    title: Text("OPPS"),
    content: Text(
      "A passwors reset link has been sent to $email ",
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SignInPage()));
            // Navigator.pop(context);
          },
          child: Text("OK"))
    ],
  );
  showDialog(context: context, builder: (_) => alertDialog);
  return alertDialog;
}
