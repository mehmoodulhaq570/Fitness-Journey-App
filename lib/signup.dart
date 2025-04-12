import 'package:fit_journey/exercise/exercise.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_journey/Dashboard.dart';

import 'goals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
    ),
    home: RegisterScreen(),
  ));
}

class RegisterScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get _isFormValid {
    return _username.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _confirmPassword == _password &&
        _acceptTerms;
  }

  Future<void> _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account Created Successfully")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FitnessGoalsApp()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/fitness_image.png', height: 100),
                  SizedBox(height: 10),
                  Text(
                    "Create Your Account",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: _inputDecoration("Username", Icons.person),
                    onChanged: (value) => setState(() => _username = value),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: _inputDecoration("Email Address", Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => setState(() => _email = value),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: _inputDecoration("Password", Icons.lock),
                    obscureText: true,
                    onChanged: (value) => setState(() => _password = value),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: _inputDecoration("Confirm Password", Icons.lock),
                    obscureText: true,
                    onChanged: (value) => setState(() => _confirmPassword = value),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        activeColor: Colors.blue,
                        onChanged: (value) => setState(() => _acceptTerms = value!),
                      ),
                      Expanded(
                        child: Text(
                          "I accept the Privacy Policy and Terms of Service",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isFormValid ? _register : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormValid ? Colors.blue : Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Create My Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white),
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white54),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    );
  }
}
