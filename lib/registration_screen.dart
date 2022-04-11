import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';
import 'mynotes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b1f24),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                        color: Color(0xffFEB52B),
                        fontWeight: FontWeight.w600,
                        fontSize: 60.0),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Register your account',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 76.0),
              Container(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Email',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 350,
                child: TextField(
                  obscureText: true,     //hidden password text.
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyNotes(),
                      ));
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  child: Text('Sign Up'),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(350, 40),
                  primary: Color(0xff3369FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
