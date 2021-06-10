import 'package:fire_base_app/registrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  bool ispasswordVisible = true;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SignIn",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: emailContoller,
                decoration: InputDecoration(
                    hintText: "Enter email",
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.green,
                    )),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: ispasswordVisible,
                textAlign: TextAlign.center,
                controller: passwordContoller,
                decoration: InputDecoration(
                    hintText: "Enter password",
                    suffixIcon: IconButton(
                      splashColor: Colors.black87,
                      icon: Icon(ispasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          ispasswordVisible = !ispasswordVisible;
                        });
                      },
                    )),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Don't have account?"),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "SIGNUP",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  )),
              MaterialButton(
                  color: Colors.green,
                  child: Text("SignIn"),
                  onPressed: () async {
                    setState(() {
                      isloading = true;
                    });
                    try {
                      final currentUser = await auth.signInWithEmailAndPassword(
                          email: emailContoller.text,
                          password: passwordContoller.text);
                      if (currentUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MyHomePage(
                                      userID: currentUser.user.uid,
                                    )));
                        setState(() {
                          isloading = false;
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
                          title: Text("Exception!kfkkkfk"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"))
                          ],
                        ),
                      );

                      setState(() {
                        isloading = false;
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
