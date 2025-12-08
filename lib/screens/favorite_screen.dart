import 'package:chef_mate/screens/meal_details_screen.dart';
import 'package:chef_mate/services/favorites_service.dart';
import 'package:chef_mate/widgets/meals/meal_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = Provider.of<FavoritesService>(context).favoriteMeals;

    return Scaffold(
      appBar: AppBar(title: const Text('Омилени рецепти')),
      body: favoriteMeals.isEmpty
          ? const Center(child: Text('Немате омилени рецепти'))
          : ListView.builder(
        // 💡 КЛУЧНО: Додадете го ова за да го отстраните bottom padding-от.
        padding: const EdgeInsets.only(bottom: 16.0), // Може да додадете малку простор

        itemCount: favoriteMeals.length,
        itemBuilder: (context, index) {
          final meal = favoriteMeals[index];
          return Padding(
            // Додадете малку простор околу секоја картичка
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: MealCard(
              meal: meal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MealDetailsScreen(mealId: meal.id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}