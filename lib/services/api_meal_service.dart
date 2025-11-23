import 'dart:convert';
import 'package:chef_mate/models/category.dart';
import 'package:chef_mate/models/meal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseURL = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseURL/categories.php'));
    final data = json.decode(response.body);
    return (data['categories'] as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  static Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseURL/filter.php?c=$category'),
    );
    final data = json.decode(response.body);
    return (data['meals'] as List).map((json) => Meal.fromJson(json)).toList();
  }

  static Future<Meal> getMealDetails(String id) async {
    final response = await http.get(Uri.parse('$baseURL/lookup.php?i=$id'));
    final data = json.decode(response.body);
    return Meal.fromJson(data['meals'][0]);
  }

  static Future<Meal> getRandomMeal() async {
    final response = await http.get(Uri.parse('$baseURL/random.php'));
    final data = json.decode(response.body);
    return Meal.fromJson(data['meals'][0]);
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseURL/search.php?s=$query'));
    final data = json.decode(response.body);

    if (data['meals'] == null) return [];

    return (data['meals'] as List).map((json) => Meal.fromJson(json)).toList();
  }
}
