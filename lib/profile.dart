import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_journey/Dashboard.dart';
import 'package:fit_journey/community.dart';
import 'package:fit_journey/exercise/exercise.dart';
import 'package:fit_journey/recipes.dart';
import 'dairy.dart';
import 'app_startup.dart';
import 'nutrition_plan_screen.dart';
import 'setps_counter.dart';
import 'nutrition_plan_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser; // Get the logged-in user
  }

  // Logout Function
  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fit Journey",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          //Text("Streak", style: TextStyle(color: Colors.grey)),
                         // SizedBox(height: 4),
                         // Text("3 days", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade900,
                        child: Image.asset('assets/fitness_image.png'),
                      ),
                      Column(
                        children: [
                        //  Text("Progress", style: TextStyle(color: Colors.grey)),
                         // SizedBox(height: 4),
                          //Text("70 kg", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    _user?.email ?? "User Email", // Show signed-in user's email
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildListItem(
                    context,
                    Icons.workspace_premium,
                    "Try Premium for Free",
                    isPremium: true,
                    onTap: () => _showPremiumPopup(context), // Open popup when tapped
                  ),
                  buildListItem(context, Icons.restaurant_menu, "Recipes", route: RecipeScreen()),
                  buildListItem(context, Icons.snowshoeing, "Setps", route: StepCounter()),
                  buildListItem(context, Icons.change_circle_outlined, "Nutritions", route: NutritionPlanScreen()),
                  //buildListItem(context, Icons.restaurant_menu, "Recipes", route: HomeScreen()),
                  buildListItem(context, Icons.menu_book, "Diary", route: DiaryScreen()),
                  buildListItem(context, Icons.nightlight_round, "Sleep", route: DashboardScreen()),
                  buildListItem(context, Icons.fitness_center, "Exercises", route: ExerciseScreen()),
                  buildListItem(context, Icons.groups_sharp, "Community", route: CommunityChatScreen()),


                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text("Logout", style: TextStyle(color: Colors.red)),
                    onTap: _logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, IconData icon, String title,
      {bool isNew = false, bool isPremium = false, Widget? route, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: isPremium ? Colors.yellow : Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: isNew
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("NEW", style: TextStyle(color: Colors.white, fontSize: 12)),
      )
          : Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
      onTap: onTap ?? () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        }
      },
    );
  }
}

void _showPremiumPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.workspace_premium, color: Colors.amber, size: 60),
              SizedBox(height: 10),
              Text("Upgrade to Premium!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text("Get exclusive access to premium workouts, diet plans, and more!",
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 14)),
              SizedBox(height: 16),
              Column(
                children: [
                  _premiumFeature("✔ Ad-free experience"),
                  _premiumFeature("✔ Access to exclusive workouts"),
                  _premiumFeature("✔ Personalized diet plans"),
                  _premiumFeature("✔ Priority support"),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Redirecting to Payment...")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Buy Now - \$9.99 / month", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              SizedBox(height: 10),
              TextButton(onPressed: () => Navigator.pop(context), child: Text("No, Thanks", style: TextStyle(color: Colors.white70))),
            ],
          ),
        ),
      );
    },
  );
}

Widget _premiumFeature(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.amber, size: 18),
        SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    ),
  );
}
