import 'package:flutter/material.dart';
import 'package:fit_journey/gender.dart';
import 'package:fit_journey/goalweight.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:fit_journey/weight.dart';

void main() {
  runApp(const HeightSelectionApp());
}

class HeightSelectionApp extends StatelessWidget {
  const HeightSelectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Dark mode
      home: const HeightScreen(),
    );
  }
}

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double selectedHeight = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fit Journey'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>GoalWeightScreen()));
            // Handle back action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "What is Your Height",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text(
              "Select your height in feet",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: selectedHeight * 80,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35), // Add right padding
                          child: Image.asset('assets/height.png', fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 20),
                  Expanded(
                    child: SfSlider.vertical(
                      value: selectedHeight,
                      min: 3.0,
                      max: 6.5,
                      interval: 0.5,
                      showLabels: true,
                      showTicks: true,
                      onChanged: (value) {
                        setState(() {
                          selectedHeight = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedHeight > 0 ? Colors.blue : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: selectedHeight > 0
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GenderSelectionScreen()),
                  );
                }
                    : null,
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
