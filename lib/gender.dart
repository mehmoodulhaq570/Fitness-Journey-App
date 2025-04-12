import 'package:flutter/material.dart';
import 'package:fit_journey/DOB.dart';

class GenderSelectionScreen extends StatefulWidget {
  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

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
            Image.asset('assets/fitness_image.png', height: 145),
            //_buildProgressBar(),
            SizedBox(height: 30),
            Text(
              "What's your Gender?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildGenderOption("Male", Icons.male),
            SizedBox(height: 10),
            _buildGenderOption("Female", Icons.female),
            Spacer(),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }


  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: 0.5, // Adjust the progress accordingly
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 30),
            SizedBox(width: 10),
            Text(
              gender,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
            Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.blue, size: 24),
          ],
        ),
      ),
    );
  }


  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: selectedGender == null ? null : () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DOBSelectionScreen()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        //padding: EdgeInsets.symmetric(vertical: 14, horizontal: 90),
        padding: const EdgeInsets.symmetric(vertical:14, horizontal: 113),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        "Continue",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );













  }

}
