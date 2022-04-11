import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'mynotes.dart';

String title;
String des;

class EditNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  EditNote({this.data, this.time, this.ref});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];         //very important to update the data without giving null to the unchanged data.
    des = widget.data['description'];
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
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //to access the document.
                            widget.ref.update(
                              {
                                'title': title,
                                'description': des,
                                'created': DateTime.now()
                              },
                            ).whenComplete(() => Navigator.pop(context));
                          },
                          child: Icon(Icons.edit_rounded),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff3369FF),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () async {
                            await widget.ref.delete();
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.delete_forever),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[800],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: widget.data['title'],
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
                          initialValue: widget.data['description'],
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
