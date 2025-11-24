import 'package:chef_mate/screens/meal_details_screen.dart';
import 'package:chef_mate/widgets/meals/meal_card.dart';
import 'package:flutter/material.dart';

import '../../models/meal.dart';

class MealGrid extends StatelessWidget {
  final List<Meal> meals;

  const MealGrid({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(12),
        itemCount: meals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final meal = meals[index];
          return MealCard(
            meal: meal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MealDetailsScreen(mealId: meal.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
