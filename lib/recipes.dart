import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Immune Support",
      "recipes": [
        {"image": "assets/R1.png", "title": "Chipotle Egg Bean", "calories": "252 Cal"},
        {"image": "assets/R2.png", "title": "Lime-Chili Chicken", "calories": "231 Cal"},
        {"image": "assets/R3.png", "title": "Green Gazpacho", "calories": "151 Cal"},
        {"image": "assets/R4.png", "title": "Avocado Toast", "calories": "300 Cal"},
      ],
    },
    {
      "title": "Pantry Staples",
      "recipes": [
        {"image": "assets/R5.png", "title": "Savory Almond Flour Muffins", "calories": "270 Cal"},
        {"image": "assets/R6.png", "title": "Chickpea-Pecan Blondies", "calories": "132 Cal"},
        {"image": "assets/R7.png", "title": "Oatmeal Pancakes", "calories": "320 Cal"},
        {"image": "assets/R8.png", "title": "Homemade Granola", "calories": "250 Cal"},
      ],
    },
    {
      "title": "Pre-Workout",
      "recipes": [
        {"image": "assets/R9.png", "title": "Berry Protein Smoothie", "calories": "180 Cal"},
        {"image": "assets/R10.png", "title": "Peanut Butter Oatmeal", "calories": "320 Cal"},
        {"image": "assets/R11.png", "title": "Banana Nut Shake", "calories": "250 Cal"},
        {"image": "assets/R12.png", "title": "Energy Boost Bites", "calories": "200 Cal"},
      ],
    },
    {
      "title": "Healthy Recipes",
      "recipes": [
        {"image": "assets/R13.png", "title": "Greek Yogurt Bowl", "calories": "150 Cal"},
        {"image": "assets/R14.png", "title": "Hummus with Veggies", "calories": "120 Cal"},
        {"image": "assets/R15.png", "title": "Coconut Chia Pudding", "calories": "200 Cal"},
        {"image": "assets/R16.png", "title": "Apple Pest Letn", "calories": "180 Cal"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    theme: ThemeData.dark();

    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes", style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: categories.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Title & View More
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category["title"],
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("View More", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                // Horizontal Recipe List
                Container(
                  height: 180, // Adjust height based on design
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category["recipes"].length,
                    itemBuilder: (context, index) {
                      var recipe = category["recipes"][index];
                      return Container(
                        width: 150, // Adjust width
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Recipe Image
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              child: Image.asset(
                                recipe["image"],
                                width: 150,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe["title"],
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(recipe["calories"], style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
