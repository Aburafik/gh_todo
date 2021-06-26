import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_app/registrationScreen.dart';
import 'package:fire_base_app/signIn.dart';
import 'package:fire_base_app/update_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final User user = auth.currentUser;
Color primaryColor = Color(0xffBCBCBC);
Color titleColor = Color(0xff6E6E6E);

class MyHomePage extends StatefulWidget {
  String userID;
  MyHomePage({this.userID});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController;
  TextEditingController descriptionController;
  // String userID;
  var id;
  // Timestamp timestamp;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    // getUserData();
    // id = auth.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242424),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                auth.signOut();

                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignInPage()));
              })
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Task Tracker"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        //check if List is empty show image else .....
        child: StreamBuilder<QuerySnapshot>(
          stream: firebaseFirestore.collection(widget.userID).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // firebaseFirestore.doc(userID).id == null
              return snapshot.data.docs.isEmpty
                  ? Image.asset(
                      "images/addtodo.png",
                      height: 500,
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        var getData = snapshot.data.docs[index];
                        var dateTime = DateTime.fromMillisecondsSinceEpoch(
                            snapshot.data.docs[index]['timestamp']);

                        var formatDate = DateFormat(' EEE, d/M/y\n kk:mm')
                            .format(dateTime)
                            .toString();

                        return Card(
                          color: Color(0xff3E3E3E),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    getData["title"],
                                    style: TextStyle(
                                        fontSize: 25, color: primaryColor),
                                  ),
                                  subtitle: Text(
                                    getData['description'],
                                    style: TextStyle(
                                        color: titleColor, fontSize: 20),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //check if formatDate is null
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        formatDate.toString() == null
                                            ? ""
                                            : formatDate.toString(),
                                        style: TextStyle(color: titleColor),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      UpDateData(
                                                    snapshot: snapshot.data,
                                                    index: index,
                                                  ),
                                                );
                                              }),
                                          IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .runTransaction((Transaction
                                                        transaction) async {
                                                  transaction.delete(snapshot
                                                      .data
                                                      .docs[index]
                                                      .reference);
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
              // : Text("Data is Empty");
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          addData(context);
        },
        child: Icon(
          FontAwesomeIcons.pen,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  addData(BuildContext context,
      {QueryDocumentSnapshot snapshot, Timestamp timestamp}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // contentPadding: EdgeInsets.zero,
        content: Container(
          height: 300,
          child: Column(
            children: [
              Text("Add Task"),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Tile here"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: "Description here"),
              ),
              Spacer(),
              MaterialButton(
                shape: StadiumBorder(),
                color: Colors.teal,
                child: Text("Add Task"),
                onPressed: () {
                  firebaseFirestore.collection(widget.userID).add({
                    "title": titleController.text,
                    "description": descriptionController.text,
                    "timestamp": Timestamp.now().millisecondsSinceEpoch
                  });

                  titleController.clear();
                  descriptionController.clear();

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
