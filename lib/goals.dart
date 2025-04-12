import 'package:flutter/material.dart';
import 'package:fit_journey/weight.dart';

void main() {
  runApp(const FitnessGoalsApp());
}

class FitnessGoalsApp extends StatelessWidget {
  const FitnessGoalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Dark mode
      home: const GoalsScreen(),
    );
  }
}

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final List<String> goals = [
    "Lose Weight",
    "Build Muscle",
    "Weight Gain",
    "Strength"
  ];

  final List<IconData> icons = [
    Icons.local_fire_department, // Lose weight
    Icons.fitness_center, // Build muscle
    Icons.scale, // Weight gain
    Icons.bolt, // Increase energy
  ];

  final Set<String> selectedGoals = {}; // Track selected goals

  void _toggleSelection(String goal) {
    setState(() {
      if (goal == "Lose Weight" || goal == "Weight Gain") {
        selectedGoals.remove("Lose Weight");
        selectedGoals.remove("Weight Gain");
      }
      if (!selectedGoals.contains(goal)) {
        selectedGoals.add(goal);
      } else {
        selectedGoals.remove(goal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/fitness_image.png', height: 145),
            const SizedBox(height: 20),
            const Text(
              "What are your goals?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            const Text(
              "Select Goals",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(goals.length, (index) {
                final goal = goals[index];
                final isSelected = selectedGoals.contains(goal);
                return GestureDetector(
                  onTap: () => _toggleSelection(goal),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[900],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected ? Colors.greenAccent : Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icons[index], size: 40, color: Colors.white),
                        const SizedBox(height: 10),
                        Text(
                          goal,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  selectedGoals.isEmpty ? Colors.grey : Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: selectedGoals.isNotEmpty
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WeightScreen()),
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
