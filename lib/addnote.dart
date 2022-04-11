import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mynotes.dart';

User loggedInUser;
String title;
String des;

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1b1f24),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyNotes(),
                          ),
                        );
                      },
                      child: Icon(Icons.arrow_back_ios_outlined),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3369FF),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('notes')
                            .doc(loggedInUser.email)
                            .collection('notes')
                            .add({
                          'title': title,
                          'description': des,
                          'created': DateTime.now()
                        }).whenComplete(() => Navigator.pop(context));
                      },
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff3369FF),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'Title'),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                        onChanged: (_value) {
                          title = _value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                              hintText: 'Add Description'),
                          style: TextStyle(fontSize: 20),
                          onChanged: (_value) {
                            des = _value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
