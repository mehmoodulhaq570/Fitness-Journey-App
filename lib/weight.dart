import 'package:flutter/material.dart';
import 'package:fit_journey/gender.dart';
import 'package:fit_journey/goalweight.dart';

class WeightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit Journey'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Center(child: Image.asset('assets/fitness_image.png', height: 140)),


            SizedBox(height: 20),
            Text(
              "What's your weight?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Enter weight",
                suffixIcon: ToggleButtons(
                  children: [Text("lb"), Text("kg")],
                  isSelected: [false, true],
                  onPressed: (int index) {},
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("Enter Your Current Body Weight"),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: Colors.blue, // Changed button color to blue
                borderRadius: BorderRadius.circular(30),
              ),
              width: double.infinity,


              child: TextButton(
                
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GoalWeightScreen()));

                },
                child: Text(
                  "Continue",

                  style: TextStyle(color: Colors.white, fontSize: 18),

                ),
              ),

            ),
            SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}
