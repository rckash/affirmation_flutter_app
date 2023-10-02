import 'package:affirmation_flutter_app/theme/dark_theme.dart';
import 'package:affirmation_flutter_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/main_scaffold.dart';
import 'services/notification_services.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // notifications init
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();

  // hive init
  await Hive.initFlutter();
  var box = await Hive.openBox('journalBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainScaffold(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}