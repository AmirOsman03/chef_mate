import 'package:chef_mate/models/meal.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> meals;

  const FavoriteScreen({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = meals.where((m) => m.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Your favorite meals")),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final meal = favoriteMeals[index];
          return ListTile(
            title: Text(meal.name),
            leading: Image.network(meal.thumbnail),
          );
        },
      ),
    );
  }
}
