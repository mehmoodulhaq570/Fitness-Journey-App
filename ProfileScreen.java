import 'package:flutter/material.dart';
import 'package:fit_journey/Dashboard.dart';
import 'package:fit_journey/community.dart';
import 'package:fit_journey/exercise/exercise.dart';
import 'package:fit_journey/main.dart';
import 'package:fit_journey/recipes.dart';
import 'dairy.dart';
import 'app_startup.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    theme: ThemeData.dark();

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
            // Profile Header
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
                          Text("Streak", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 4),
                          Text("8 days", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade900,
                        child: Image.asset('assets/fitness_image.png'),
                      ),
                      Column(
                        children: [
                          Text("Progress", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 4),
                          Text("70 kg", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Fit Journey",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Options List
            Expanded(
              child: ListView(
                children: [
                  buildListItem(context, Icons.workspace_premium, "Try Premium for Free", isPremium: true, route: DashboardScreen()),
                  buildListItem(context, Icons.restaurant_menu, "Recipes", route: RecipeScreen()),

                  buildListItem(context, Icons.menu_book, "Diary", route: DiaryScreen()),

                  buildListItem(context, Icons.nightlight_round, "Sleep", route:DashboardScreen()),
                  buildListItem(context, Icons.fitness_center, "Exercises", route: ExerciseScreen()),

                  buildListItem(context, Icons.groups_sharp, "Community", route: CommunityChatScreen()),
                  buildListItem(context, Icons.output, "Logout", route: FitnessApp()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, IconData icon, String title, {bool isNew = false, bool isPremium = false, required Widget route}) {
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
    );
  }
}


