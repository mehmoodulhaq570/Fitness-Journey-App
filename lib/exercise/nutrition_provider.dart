import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NutritionProvider with ChangeNotifier {
  Map<String, dynamic>? nutritionData;
  bool isLoading = true;

  NutritionProvider() {
    fetchNutritionData();
  }

  get nutritionPlan => null;

  void fetchNutritionData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      nutritionData = doc['nutritionPlan'];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching nutrition data: $e");
      isLoading = false;
      notifyListeners();
    }
  }
}
