import 'package:chef_mate/models/category.dart';
import 'package:chef_mate/screens/meals_screen.dart';
import 'package:chef_mate/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;

  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MealsScreen(categoryName: category.name),
                ),
              );
            },
            child: CategoryCard(category: category),
          );
        },
      ),
    );
  }
}
