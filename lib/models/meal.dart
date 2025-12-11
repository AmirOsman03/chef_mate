class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final List<String> ingredients;
  final List<String> measures;
  final String youtubeLink;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.ingredients,
    required this.measures,
    required this.youtubeLink,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    // Сите 20 можни состојки и мерења од API-то
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'] ?? '';
      final measure = json['strMeasure$i'] ?? '';
      if (ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString());
        measures.add(measure.toString());
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
      measures: measures,
      youtubeLink: json['strYoutube'] ?? '',
    );
  }

}
