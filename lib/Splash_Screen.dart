import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_journey/Dashboard.dart';
import 'app_startup.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLogin();
  }

  void _checkUserLogin() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading time
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User already logged in, go to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      // User not logged in, go to Welcome Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/fitness_image.png', height: 200),
            SizedBox(height: 20),
           // Text('Fit Journey',style: TextStyle(fontSize: 30),)
            CircularProgressIndicator(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
