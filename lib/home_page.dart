import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_app/registrationScreen.dart';
import 'package:fire_base_app/signIn.dart';
import 'package:fire_base_app/update_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final User user = auth.currentUser;

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

  // getUserData() {
  //   User userData = user;
  //   userID = userData.uid;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Text(userEmail),
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
        child: widget.userID == null
            ? Center(
                child: Text("Empty"),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore.collection(widget.userID).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // firebaseFirestore.doc(userID).id == null
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var getData = snapshot.data.docs[index];
                          var dateTime = DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data.docs[index]['timestamp']);

                          var formatDate = DateFormat("dd-kk:mm")
                              .format(dateTime)
                              .toString();

                          return Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      getData["title"],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(getData['description']),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                                  await FirebaseFirestore
                                                      .instance
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
                                      Text(formatDate.toString() == null
                                          ? ""
                                          : formatDate.toString())
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
        child: Icon(Icons.add),
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
                color: Colors.grey,
                child: Text("Add Task"),
                onPressed: () {
                  // firebaseFirestore.collection(userID).add({});
                  // if (firebaseFirestore.collection("Todo")== null)
                  // if (firebaseFirestore.collection(userID).snapshots() =)
                  firebaseFirestore.collection(widget.userID).add({
                    "title": titleController.text,
                    "description": descriptionController.text,
                    "timestamp": Timestamp.now().millisecondsSinceEpoch
                  });

                  // firebaseFirestore.collection(userID).add({
                  //   "title": titleController.text,
                  //   "description": descriptionController.text,
                  //   "timestamp": Timestamp.now().millisecondsSinceEpoch
                  // });
                  print(widget.userID);
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
