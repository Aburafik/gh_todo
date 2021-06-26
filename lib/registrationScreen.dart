import 'package:fire_base_app/reUsable_widgets.dart';
import 'package:fire_base_app/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  TextEditingController nameController = TextEditingController();
  bool isregistrining = false;
  @override
  Widget build(BuildContext context) {
    TextStyle optionStyle = Theme.of(context)
        .textTheme
        .headline2
        .copyWith(fontSize: 20, color: Color(0xffDFDEDF));
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isregistrining,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
              ),
              authScreenTitle(title: "Sign Up"),
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: Row(
                  children: [
                    Text(
                      "Already, have an account?",
                      style: optionStyle,
                    ),
                    GestureDetector(
                      child: Text(
                        "Sign In",
                        style: optionStyle.copyWith(
                            color: Colors.yellow,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignInPage()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                height: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: nameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff464450),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(40)),
                      hintText: "Enter Your Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xffFFFFFF),
                      )),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: emailContoller,
                  decoration: InputDecoration(
                    hintText: "Enter email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xffFFFFFF),
                    ),
                    filled: true,
                    fillColor: Color(0xff464450),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(
                    top: 30, bottom: MediaQuery.of(context).size.height * 0.05),
                height: 50,
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  controller: passwordContoller,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    prefixIcon: Icon(
                      FontAwesomeIcons.key,
                      size: 20,
                      color: Color(0xffFFFFFF),
                    ),
                    filled: true,
                    fillColor: Color(0xff464450),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              Container(
                width: 120,
                // margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.only(
                  right: 200,
                ),
                // margin: EdgeInsets.symmetric(horizontal: 50),
                child: MaterialButton(
                    shape: StadiumBorder(),
                    color: Color(0xffE8D318),
                    child: Row(
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Color(0xff1A1703),
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 30,
                          color: Color(0xff1A1703),
                        )
                      ],
                    ),
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        return showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Text(
                              "Opps Looks like there is an empty field",
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
                      } else {
                        setState(() {
                          isregistrining = true;
                        });
                        try {
                          final newUser =
                              await auth.createUserWithEmailAndPassword(
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
                      }
                    }),
              ),
              // Spacer(),
              socialMediaHandle(),
              copyRight()
            ],
          ),
        ),
      ),
    );
  }
}
