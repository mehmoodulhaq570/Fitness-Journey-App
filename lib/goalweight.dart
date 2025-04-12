import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'height.dart';
import 'nutrition_plan_screen.dart';

class GoalWeightScreen extends StatefulWidget {
  @override
  _GoalWeightScreenState createState() => _GoalWeightScreenState();
}

class _GoalWeightScreenState extends State<GoalWeightScreen> {
  final TextEditingController _weightController = TextEditingController();
  bool isKgSelected = true;

  // ✅ Paste this function inside the class
  void _generateNutritionPlan() async {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    if (weight == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid weight')),
      );
      return;
    }

    Map<String, dynamic> nutritionPlan = {
      'Calories': weight * 20,
      'Protein': weight * 1.5,
      'Carbohydrates': weight * 2.0,
      'Fiber': weight * 0.3,
      'Sugar': weight * 0.2,
      'Fat': weight * 0.8,
    };

    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'nutritionPlan': nutritionPlan}, SetOptions(merge: true));

    //  ScaffoldMessenger.of(context).showSnackBar(
      //  SnackBar(content: Text('Nutrition Plan Saved!')),
   //   );

      // ✅ Navigate to Nutrition Screen after saving data
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HeightScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  // ✅ Navigate to the next screen after saving data


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit Journey'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Center(child: Image.asset('assets/fitness_image.png', height: 140)),
            SizedBox(height: 20),
            Text(
              "What's your goal weight?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Enter weight",
              ),
            ),
            SizedBox(height: 10),
            Text("You can update your weight at any time"),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: _generateNutritionPlan, // ✅ Call the function here
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
