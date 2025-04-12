import 'dart:math';
import 'package:fit_journey/step_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? nutritionData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNutritionData();
  }

  void _fetchNutritionData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        nutritionData = doc['nutritionPlan'] ?? {};
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching nutrition data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView( // Scroll added here
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPremiumSection(),
                SizedBox(height: 20),
                _buildNutritionSection(),
                SizedBox(height: 20),
                _buildCyclingSection(),
                SizedBox(height: 20),
                _buildSleepWaterSection(),
                SizedBox(height: 20),
                _buildStepsCounter(),
                SizedBox(height: 20),
                _buildMotivationCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // All widget methods below are preserved exactly as you wrote them

  Widget _buildPremiumSection() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(Icons.workspace_premium, color: Colors.amber, size: 40),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upgrade to Premium!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Exclusive workouts & diet plans',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
      ],
    ),
  );

  Widget _buildNutritionSection() => Container(
    padding: EdgeInsets.symmetric(vertical:10),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularPercentIndicator(
          radius: 70.0,
          lineWidth: 8.0,
          percent: ((nutritionData?['Calories'] ?? 0) / 2500).clamp(0.0, 1.0),
          center: Text(
            "${nutritionData?['Calories'] ?? 0} Cal",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white),
          ),
          progressColor: Colors.blue,
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNutritionRow("Fiber", "${nutritionData?['Fiber'] ?? 0}g", Icons.grass),
            _buildNutritionRow("Carbs", "${nutritionData?['Carbohydrates'] ?? 0}g", Icons.fastfood),
            _buildNutritionRow("Protein", "${nutritionData?['Protein'] ?? 0}g", Icons.fitness_center),
          ],
        ),
      ],
    ),
  );

  Widget _buildNutritionRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 26),
          SizedBox(width: 9),
          Text(
            "$label: $value",
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepWaterSection() => Row(
    children: [
      Expanded(child: _buildGraphCard('Sleep', true)),
      SizedBox(width: 16),
      Expanded(child: _buildGraphCard('Water', false)),
    ],
  );

  Widget _buildGraphCard(String title, bool isSleep) => Container(
    height: 120,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        Expanded(
          child: isSleep ? _buildSleepChart() : _buildWaterChart(),
        ),
      ],
    ),
  );

  Widget _buildSleepChart() => LineChart(
    LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2),
            FlSpot(1, 5),
            FlSpot(2, 3),
            FlSpot(3, 7),
            FlSpot(4, 4),
          ],
          isCurved: true,
          color: Colors.blue,
          dotData: FlDotData(show: false),
        ),
      ],
    ),
  );

  Widget _buildWaterChart() => BarChart(
    BarChartData(
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(enabled: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [BarChartRodData(toY: 8, color: Colors.blue)],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [BarChartRodData(toY: 4, color: Colors.blue)],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [BarChartRodData(toY: 6, color: Colors.blue)],
        ),
      ],
    ),
  );

  Widget _buildStepsCounter() {
    return Consumer<StepProvider>(
      builder: (context, stepProvider, child) {
        int steps = stepProvider.steps;
        int goalSteps = 2000;

        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Steps', style: TextStyle(color: Colors.white54, fontSize: 14)),
                  Text(
                    '$steps / $goalSteps',
                    style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 30,
                lineWidth: 6,
                percent: (steps / goalSteps).clamp(0.0, 1.0),
                progressColor: Colors.blue,
                backgroundColor: Colors.grey,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '${((steps / goalSteps) * 100).toStringAsFixed(0)}%',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMotivationCard() => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        'Keep it Up!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  Widget _buildCyclingSection() => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cycling',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '45 min',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ],
        ),
      ),
      CircularPercentIndicator(
        radius: 40,
        lineWidth: 8,
        percent: 0.87,
        progressColor: Colors.blue,
        backgroundColor: Colors.grey[800]!,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          '87%',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      )
    ],
  );
}