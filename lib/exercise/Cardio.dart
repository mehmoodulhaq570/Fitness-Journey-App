import 'package:flutter/material.dart';



class CardioExercise extends StatelessWidget {
  final List<Map<String, dynamic>> exercises = [
    {
      "title": "Sprinting",
      "subtitle": "20 Mints Today",
      "image": "assets/C1.png", // Add your image path
      "progress": 0.75,
    },
    {
      "title": "Rope Through",
      "subtitle": "30 Raps Today",
      "image": "assets/C2.png",
      "progress": 0.60,
    },
    {
      "title": "Stair Climbing",
      "subtitle": "15 Mints Today",
      "image": "assets/C3.png",
      "progress": 0.80,
    },

    {
      "title": "Cycling",
      "subtitle": "20 mints Today",
      "image": "assets/6.png", // Add your image path
      "progress": 0.75,
    },

  ];

  @override
  Widget build(BuildContext context) {
    theme: ThemeData.dark();

    return Scaffold(
      /* AppBar(
    title: Text(
    'Your Title',
    style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Colors.blue,
    )*/
      appBar: AppBar(
        title: Text("Cardio Exercises", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900], // Dark box color
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      exercise["image"],
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise["title"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          exercise["subtitle"],
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: exercise["progress"],
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}




