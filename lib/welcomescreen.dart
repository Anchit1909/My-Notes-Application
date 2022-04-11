import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_notes_app/login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final String assetName = 'assets/welcomescreen.svg';
  final Widget svg =
      SvgPicture.asset('welcomescreen.svg', semanticsLabel: 'Acme Logo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b1f24),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200, bottom: 50),
              child: SvgPicture.asset(
                'images/welcomescreen.svg',
                height: 240.0,
                width: 240.0,
                alignment: Alignment.center,
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.0),
              child: Text(
                'Create Free Notes',
                style: TextStyle(
                    color: Color(0xffFEB52B),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Create and manage your notes',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Container(
                child: Text('Log In'),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(240, 40),
                primary: Color(0xff3369FF),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ),
                );
              },
              child: Container(
                child: Text('Sign Up'),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(240, 40),
                primary: Color(0xff3369FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
