import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepProvider with ChangeNotifier {
  int _steps = 0;
  int get steps => _steps;

  StepProvider() {
    _initStepCounter();
  }

  Future<void> _initStepCounter() async {
    if (await Permission.activityRecognition.request().isGranted) {
      Pedometer.stepCountStream.listen((StepCount stepCount) {
        _steps = stepCount.steps;
        notifyListeners(); // Notify UI to update
      }).onError((error) {
        print("Error: $error");
      });
    }
  }
}
