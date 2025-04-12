import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  late StreamSubscription<int> _subscription;
  int _steps = 0;
  final int _goalSteps = 2000;

  @override
  void initState() {
    super.initState();
    _initStepCounter();
  }

  Future<void> _initStepCounter() async {
    if (await Permission.activityRecognition.request().isGranted) {
      Pedometer.stepCountStream.listen((StepCount stepCount) {
        setState(() {
          _steps = stepCount.steps;
        });
      }).onError((error) {
        print("Error: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Step Counter", style: TextStyle(color: Colors.white)),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 120,
              lineWidth: 10,
              percent: (_steps / _goalSteps).clamp(0.0, 1.0),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey[800]!,
              circularStrokeCap: CircularStrokeCap.round,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.footprints, color: Colors.blue, size: 40),
                  SizedBox(height: 10),
                  Text(
                    '$_steps / $_goalSteps',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${((_steps / _goalSteps) * 100).toStringAsFixed(0)}%',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Keep moving!",
              style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
