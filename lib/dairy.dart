import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'profile.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => _DiaryScreenState();

}

class _DiaryScreenState extends State<DiaryScreen> {
  List<String> exercises = ["Push-ups", "Running","Cardio","Dead lift", "Jump Rope"]; // Default added exercises

  void addExercise(String exercise) {
    setState(() {
      exercises.add(exercise);
    });
  }

  @override
  Widget build(BuildContext context) {
    theme: ThemeData.dark();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Diary", style: TextStyle(color: Colors.white)),
        centerTitle: true,

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return ExerciseCard(exercise: exercises[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          final newExercise = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExerciseScreen()),
          );

          if (newExercise != null) {
            addExercise(newExercise);
          }
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String exercise;

  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(exercise, style: TextStyle(color: Colors.white, fontSize: 18)),
        trailing: Icon(Icons.fitness_center, color: Colors.blue),
      ),
    );
  }
}



class AddExerciseScreen extends StatelessWidget {
  final List<String> allExercises = [
    "Push-ups",
    "Squats",
    "Jump Rope",
    "Bench Press",
    "Cycling",
    "Swimming",
    "Yoga",
    "Deadlifts"
        "Swimming",
    "Plank",
    "Pull Over",

  ];

  @override
  Widget build(BuildContext context) {
    theme: ThemeData.dark();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Exercise", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: allExercises.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[900],
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(allExercises[index], style: TextStyle(color: Colors.white, fontSize: 18)),
              trailing: IconButton(
                icon: Icon(Icons.add, color: Colors.blue),
                onPressed: () {
                  Navigator.pop(context, allExercises[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

