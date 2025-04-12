import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NutritionPlanScreen extends StatefulWidget {
  @override
  _NutritionPlanScreenState createState() => _NutritionPlanScreenState();
}

class _NutritionPlanScreenState extends State<NutritionPlanScreen> {
  Map<String, dynamic>? nutritionPlan;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNutritionPlan();
  }

  void _fetchNutritionPlan() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        nutritionPlan = doc['nutritionPlan'];
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Nutrition Plan'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [                    SizedBox(height: 40,),

            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: (nutritionPlan!['Calories'] / 2500).clamp(0.0, 1.0),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Icon(Icons.local_fire_department, size: 30, color: Colors.orange),
                    Text(
                      "${nutritionPlan!['Calories']} kcal",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                progressColor: Colors.orange,
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            SizedBox(height: 20),
            _buildProgressBar("Protein", nutritionPlan!['Protein'], 150, Colors.green, Icons.fitness_center),
            SizedBox(height: 20,),

            _buildProgressBar("Carbohydrates", nutritionPlan!['Carbohydrates'], 300, Colors.blue, Icons.fastfood),
            SizedBox(height: 20,),

            _buildProgressBar("Fiber", nutritionPlan!['Fiber'], 50, Colors.purple, Icons.grass),
            SizedBox(height: 20,),

            _buildProgressBar("Sugar", nutritionPlan!['Sugar'], 30, Colors.red, Icons.cake),
            SizedBox(height: 20,),

            _buildProgressBar("Fat", nutritionPlan!['Fat'], 70, Colors.brown, Icons.water_drop),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(String label, double value, double maxValue, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$label: ${value.toStringAsFixed(1)}g", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                LinearProgressIndicator(
                  value: (value / maxValue).clamp(0.0, 1.0),
                  backgroundColor: Colors.grey[300],
                  color: color,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}