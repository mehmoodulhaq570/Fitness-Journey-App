import 'package:flutter/material.dart';
import 'package:fit_journey/exercise/Biceps.dart';
import 'package:fit_journey/exercise/Shoulders.dart';
import 'package:fit_journey/exercise/back.dart';
import 'package:fit_journey/exercise/chest.dart';
import 'package:fit_journey/exercise/triceps.dart';
import 'package:fit_journey/exercise/legs.dart';
import 'package:fit_journey/exercise/abs.dart';
import 'package:fit_journey/exercise/cardio.dart';

void main() {
  runApp(const ExerciseScreen());
}

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
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
    "Chest",
    "Lats",
    "Biceps",
    "Triceps",
    //"Legs",
    "Shoulder",
    "Abs",
    //"Cardio",
  ];

  final List<IconData> icons = [
    Icons.fitness_center,
    Icons.fitness_center,
    Icons.fitness_center,
    Icons.bolt,
   // Icons.directions_walk,
    Icons.sports_handball,
    Icons.bolt,
   // Icons.directions_run,
  ];

  void _navigateToNextScreen(String goal) {
    Widget nextScreen;

    switch (goal) {
      case "Chest":
        nextScreen = ChestExercise();
        break;
      case "Lats":
        nextScreen = BackExercise();
        break;
      case "Biceps":
        nextScreen = BicepsExercise();
        break;
      case "Triceps":
        nextScreen = TricepsExercise();
        break;
    /*case "Legs":
        nextScreen = LegsScreen();
        break;*/
      case "Shoulder":
        nextScreen = ShouldersExercise();
        break;
      case "Abs":
        nextScreen = AbsExercise();
        break;
      /* case "Cardio":
        nextScreen = CardioExercise();
        break;*/

      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset('assets/fitness_image.png', height: 125),
                const SizedBox(height: 20),
                const Text(
                  "Workout Exercises",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Text(
                  "Train Hard, Stay Strong!",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(goals.length, (index) {
                    final goal = goals[index];
                    return GestureDetector(
                      onTap: () => _navigateToNextScreen(goal),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
