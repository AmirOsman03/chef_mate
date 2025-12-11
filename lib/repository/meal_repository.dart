import '../models/meal.dart';
import '../services/api_meal_service.dart';

class MealsRepository {
  static final MealsRepository _instance = MealsRepository._internal();

  factory MealsRepository() => _instance;

  MealsRepository._internal();

  final Map<String, List<Meal>> _mealsByCategory = {};

  Future<List<Meal>> getMeals(String category) async {
    if (_mealsByCategory.containsKey(category)) {
      return _mealsByCategory[category]!;
    }
    final meals = await ApiService.getMealsByCategory(category);
    _mealsByCategory[category] = meals;
    return meals;
  }
}
