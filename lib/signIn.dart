import 'package:fire_base_app/reUsable_widgets.dart';
import 'package:fire_base_app/registrationScreen.dart';
import 'package:fire_base_app/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextStyle optionStyle = Theme.of(context)
        .textTheme
        .headline2
        .copyWith(fontSize: 20, color: Color(0xffDFDEDF));
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Alert!!"),
          content: Text("Are you sure you want to quite C.TODO ?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () => SystemNavigator.pop(), child: Text("Yes")),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                authScreenTitle(title: "Sign In"),
                Padding(
                  padding: EdgeInsets.only(bottom: 60, top: 20),
                  child: Row(
                    children: [
                      Text(
                        "You don't have an account?",
                        style: optionStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          "Sign Up",
                          style: optionStyle.copyWith(
                              color: Colors.yellow,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignUpPage()));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xff464450),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Enter email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xffFFFFFF),
                        )),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  height: 50,
                  child: TextField(
                    obscureText: isPasswordVisible,
                    textAlign: TextAlign.center,
                    controller: passwordController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xff464450),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Enter password",
                        suffixIcon: IconButton(
                          splashColor: Colors.black87,
                          icon: Icon(isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text("Forgot password?"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ResetPassword()));
                      },
                    ),
                  ],
                ),
                Container(
                  width: 120,
                  child: MaterialButton(
                      shape: StadiumBorder(),
                      color: Color(0xffE8D318),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              "SignIn",
                              style: TextStyle(
                                color: Color(0xff1A1703),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xff1A1703),
                            )
                          ],
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final currentUser =
                              await auth.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          if (currentUser != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyHomePage(
                                          userID: currentUser.user.uid,
                                        )));
                            setState(() {
                              isLoading = false;
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
                            isLoading = false;
                          });
                        }
                      }),
                ),
                Spacer(),
                socialMediaHandle(),
                copyRight()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
