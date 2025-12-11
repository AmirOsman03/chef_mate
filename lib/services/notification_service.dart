import 'package:chef_mate/models/meal.dart';
import 'package:chef_mate/services/api_meal_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationService {
  static Future<void> init() async {
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(iOS: iosSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  static Future<void> scheduleDailyRecipe() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Skopje'));

    final now = tz.TZDateTime.now(tz.local);
    final scheduleTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, 15, 34);

    Meal meal = await ApiService.getRandomMeal();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Meal of the day!',
      meal.name,
      scheduleTime.isBefore(now) ? scheduleTime.add(const Duration(days: 1)) : scheduleTime,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          sound: 'default',
          badgeNumber: 1,
          subtitle: 'Meal of the day!',
          threadIdentifier: 'daily_recipe_thread',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    debugPrint('нотификација закажана за: $scheduleTime');
  }

  /// Тестна нотификација за 1-2 минути од сега
  static Future<void> scheduleTestNotification() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Skopje'));

    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = now.add(const Duration(minutes: 2)); // 2 минути од сега

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Test Notification',
      'Ова е тестна нотификација!',
      scheduledTime,
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          sound: 'default',
          badgeNumber: 1,
          subtitle: 'Тест',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );

    debugPrint('Тест нотификација закажана за: $scheduledTime');
  }
}
