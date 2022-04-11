import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'addnote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'editnote.dart';

class MyNotes extends StatefulWidget {
  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
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
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b1f24),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xff3369FF),
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .whenComplete(() => Navigator.pop(context));
            },
          ),
        ],
        title: Text(
          'My Notes',
          style: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff1b1f24),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .doc(loggedInUser.email)
              .collection('notes')
              .orderBy('created', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  Map data = snapshot.data.docs[index].data();
                  // DateTime myDateTime = data['created'].toDate();
                  return InkWell(
                    //to get the splash effect on touch.
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditNote(
                              data: data,
                              time: 'created',
                              ref: snapshot.data.docs[index].reference),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(top: 20.0),
                      color: Color(0xff1b1f24),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${data['title']}",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${data['description']}",
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white60),
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.centerRight,
                            //   child: Text(
                            //     myDateTime.toString(),
                            //     style: TextStyle(
                            //       fontSize: 20.0,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('Loading...'),
              );
            }
          },
        ),
      ),
    );
  }
}
