import 'package:chef_mate/screens/meal_details_screen.dart';
import 'package:chef_mate/widgets/meals/meal_grid.dart';
import 'package:chef_mate/widgets/meals/meals_search_bar.dart';
import 'package:chef_mate/services/api_meal_service.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealsScreen extends StatefulWidget {
  final String categoryName;

  const MealsScreen({super.key, required this.categoryName});

  @override
  State<StatefulWidget> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Meal> meals = [];
  List<Meal> filteredMeals = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  void fetchMeals() async {
    meals = await ApiService.getMealsByCategory(widget.categoryName);
    filteredMeals = List.from(meals);
    setState(() {
      isLoading = false;
    });
  }

  void searchMeals(String query) async {
    if (query.isEmpty) {
      filteredMeals = meals;
    } else {
      filteredMeals = await ApiService.searchMeals(query);
    }
    setState(() {});
  }

  void showRandomMeal() async {
    Meal randomMeal = await ApiService.getRandomMeal();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealDetailsScreen(mealId: randomMeal.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          IconButton(onPressed: showRandomMeal, icon: const Icon(Icons.casino)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                MealsSearchBar(
                  controller: searchController,
                  onSearch: searchMeals,
                ),
                MealGrid(meals: filteredMeals),
              ],
            ),
    );
  }
}
