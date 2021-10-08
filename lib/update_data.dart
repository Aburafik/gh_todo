import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpDateData extends StatelessWidget {
  QuerySnapshot snapshot;
  int index;

  UpDateData({this.snapshot, this.index});
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: snapshot.docs[index]["title"]);
    TextEditingController descriptionController =
        TextEditingController(text: snapshot.docs[index]["description"]);
    return AlertDialog(
      content: Container(
        height: 300,
        child: Column(
          children: [
            Text("UpDate Data"),
            TextField(
              controller: titleController,
            ),
            TextField(
              controller: descriptionController,
            ),
            // SizedBox(height: 20),
            Spacer(),

            MaterialButton(
                shape: StadiumBorder(),
                color: Colors.teal,
                child: Text("UPDATE"),
                onPressed: () async {
                  ///Updating user todo in firestore
                  await FirebaseFirestore.instance
                      .runTransaction((Transaction transaction) async {
                    transaction.update(
                      snapshot.docs[index].reference,
                      ({
                        "title": titleController.text,
                        "description": descriptionController.text
                      }),
                    );
                  });
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
