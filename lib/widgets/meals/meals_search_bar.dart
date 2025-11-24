import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const MealsSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search Meals...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onChanged: onSearch,
      ),
    );
  }
}
