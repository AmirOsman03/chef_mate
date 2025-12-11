import 'package:chef_mate/screens/categories_screen.dart';
import 'package:chef_mate/services/favorites_service.dart';
import 'package:chef_mate/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.init();
  await NotificationService.scheduleDailyRecipe();

  runApp(
    ChangeNotifierProvider(create: (_) => FavoritesService(), child: const MealApp()),
  );
}

class MealApp extends StatelessWidget {
  const MealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Chef Mate', home: const CategoriesScreen());
  }
}
