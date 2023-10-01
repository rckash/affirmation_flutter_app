import 'package:affirmation_flutter_app/theme/dark_theme.dart';
import 'package:affirmation_flutter_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/main_scaffold.dart';
import 'services/notification_services.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: MainScaffold(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}