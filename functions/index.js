const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.getNutritionPlan = functions.https.onRequest(async (req, res) => {
  try {
    const { goalWeight } = req.body; // Get goal weight from request
    if (!goalWeight) {
      return res.status(400).json({ error: "Goal weight is required" });
    }

    // AI logic (basic example)
    let plan = {
      calories: goalWeight * 30,
      protein: goalWeight * 1.5,
      carbohydrates: goalWeight * 3,
      fiber: goalWeight * 0.8,
      sugar: goalWeight * 1.2,
      fat: goalWeight * 1.0,
    };

    return res.status(200).json({ nutritionPlan: plan });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});
