import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:fit_journey/Splash_Screen.dart';
import 'package:fit_journey/step_provider.dart';

import 'exercise/nutrition_provider.dart'; // Import the StepProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NutritionProvider()),

        ChangeNotifierProvider(create: (context) => StepProvider()), // 👈 StepProvider for step counting
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen(), // 👈 App starts with Splash Screen
    );
  }
}
