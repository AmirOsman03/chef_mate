import 'package:chef_mate/services/api_meal_service.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  final String mealId;

  const MealDetailsScreen({super.key, required this.mealId});

  @override
  State<StatefulWidget> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Meal? meal;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMealDetails();
  }

  void fetchMealDetails() async {
    meal = await ApiService.getMealDetails(widget.mealId);
    setState(() {
      isLoading = false;
    });
  }

  Widget buildIngredients() {
    if (meal == null) return const SizedBox.shrink();

    List<Widget> ingredients = [];
    for (int i = 0; i < meal!.ingredients.length; i++) {
      final ingredient = meal!.ingredients[i];
      final measure = meal!.measures[i];
      if (ingredient.isNotEmpty) {
        ingredients.add(Text('• $ingredient - $measure'));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal?.name ?? 'Loading...')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // IMAGE
                  Image.network(
                    meal!.thumbnail,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),

                  // NAME
                  Text(
                    meal!.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // INSTRUCTIONS
                  const Text(
                    'Instructions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(meal!.instructions),
                  const SizedBox(height: 16),

                  // INGREDIENTS
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  buildIngredients(),
                  const SizedBox(height: 16),

                  // YOUTUBE BUTTON
                  if (meal!.youtubeLink.isNotEmpty)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Watch on YouTube',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
