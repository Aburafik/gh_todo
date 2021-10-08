import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Row socialMediaHandle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 100,
        child: Divider(
          thickness: 1,
          color: Color(0xff515153),
        ),
      ),
      Icon(
        FontAwesomeIcons.instagramSquare,
        color: Colors.black45,
      ),
      Icon(
        FontAwesomeIcons.facebookSquare,
        color: Colors.black45,
      ),
      Icon(
        FontAwesomeIcons.twitter,
        color: Colors.black45,
      ),
      SizedBox(
        width: 100,
        child: Divider(
          thickness: 1,
          color: Color(0xff515153),
        ),
      ),
    ],
  );
}

///Copy right holder
Padding copyRight() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      "CITIZENRAF @2021. ALL RIGHT RESERVED",
      style: TextStyle(color: Color(0xff666668), wordSpacing: 5),
    ),
  );
}

///This hold the Sign In an Up title text
Text authScreenTitle({String title}) {
  return Text(
    title,
    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
  );
}
