import 'package:flutter/material.dart';
import '../../models/meal.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final VoidCallback onTap;
  final Function(Meal) onFavoriteToggle;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  State<StatefulWidget> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.meal.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      widget.meal.isFavorite = isFavorite;
      widget.onFavoriteToggle(widget.meal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(widget.meal.thumbnail, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.meal.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: toggleFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}


// @override
// Widget build(BuildContext context) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Card(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(child: Image.network(meal.thumbnail, fit: BoxFit.cover)),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               meal.name,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.favorite_border),
//             color: Colors.red,
//           ),
//         ],
//       ),
//     ),
//   );
// }
