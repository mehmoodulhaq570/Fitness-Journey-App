import 'package:flutter/material.dart';
import 'Home.dart';
import 'T_home.dart';
import 'nutrition_plan_screen.dart';
import 'profile.dart';
import 'community.dart';
import 'exercise/exercise.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    //HealthDashboard(),
    HomeScreen(),

    NutritionPlanScreen(),
    ExerciseScreen(),
    CommunityChatScreen(),
    ProfileScreen(),
   // Nutrients(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.change_circle_outlined), label: "Nutrition"),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: "Exercises"),
          BottomNavigationBarItem(icon: Icon(Icons.groups_sharp), label: "Community"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),


        ],
      ),
    );
  }
}
