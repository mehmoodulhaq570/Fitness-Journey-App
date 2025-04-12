import 'package:fit_journey/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fit_journey/signup.dart';

import 'Home.dart';

class DOBSelectionScreen extends StatefulWidget {
  @override
  _DOBSelectionScreenState createState() => _DOBSelectionScreenState();
}

class _DOBSelectionScreenState extends State<DOBSelectionScreen> {
  String selectedMonth = "January";
  int selectedDay = 1;
  int selectedYear = 1990;

  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  final List<int> days = List.generate(30, (index) => index + 1);
  final List<int> years = List.generate(36, (index) => 1990 + index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit Journey'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
           // _buildProgressBar(),
            Image.asset('assets/fitness_image.png', height: 145, ),

            SizedBox(height: 30),

            Text(
              "When's your birthday?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            _buildDropdowns(),
            Spacer(),
            _buildInfoBox(),
            SizedBox(height: 20),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Text("5/6", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: 5 / 6,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    );
  }

  Widget _buildDropdowns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDropdown("Month", selectedMonth, months, (value) {
          setState(() {
            selectedMonth = value!;
          });
        }),
        _buildDropdown("Day", selectedDay.toString(), days.map((e) => e.toString()).toList(), (value) {
          setState(() {
            selectedDay = int.parse(value!);
          });
        }),
        _buildDropdown("Year", selectedYear.toString(), years.map((e) => e.toString()).toList(), (value) {
          setState(() {
            selectedYear = int.parse(value!);
          });
        }),
      ],
    );
  }

  Widget _buildDropdown(String label, String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, textAlign: TextAlign.center),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
         // Icon(Icons.info, color: Colors.blue),
          //SizedBox(width: 10),
          /* Expanded(
            child: Text(
              "Why do you need this information? To effectively calculate your calories, macros, and carb intake.",
              style: TextStyle(fontSize: 14),
            ),
          ), */
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
        // Implement your action here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,

       padding: const EdgeInsets.symmetric(vertical:14, horizontal: 113),//vertical: 14, horizontal: 90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
    );

  }
}
