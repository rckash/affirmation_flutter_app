import 'package:affirmation_flutter_app/services/notification_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Notify'),
          onPressed:() {
            NotificationService()
              .showNotification(title: 'My title', body: 'It works!');
          },
          ) 
        ),
    );
  }
}