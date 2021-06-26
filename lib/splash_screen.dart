import 'dart:async';

import 'package:fire_base_app/signIn.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SignInPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/splash.png"),
            Text(
              "Get Things done with C.DO",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
