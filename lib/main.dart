import 'package:flutter/material.dart';
import 'package:my_notes_app/login_screen.dart';
import 'package:my_notes_app/mynotes.dart';
import 'package:my_notes_app/welcomescreen.dart';
import 'registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'addnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      home: WelcomeScreen(),
    );
  }
}
