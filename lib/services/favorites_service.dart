import 'package:chef_mate/models/meal.dart';
import 'package:flutter/material.dart';

class FavoritesService extends ChangeNotifier {
  final List<Meal> _favoriteMeals = [];

  List<Meal> get favoriteMeals => _favoriteMeals;

  bool isFavorite(Meal meal) {
    return _favoriteMeals.any((m) => m.id == meal.id);
  }

  void addFavorite(Meal meal) {
    if (!_favoriteMeals.any((m) => m.id == meal.id)) {
      _favoriteMeals.add(meal);
      notifyListeners();
    }
  }

  void removeFavorite(Meal meal) {
    _favoriteMeals.removeWhere((m) => m.id == meal.id);
    notifyListeners();
  }
}
