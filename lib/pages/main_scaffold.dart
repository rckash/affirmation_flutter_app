import 'dart:convert';
import 'package:affirmation_flutter_app/pages/home_page.dart';
import 'package:affirmation_flutter_app/pages/journal_page.dart';
import 'package:affirmation_flutter_app/pages/likes_page.dart';
import 'package:affirmation_flutter_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

DateTime scheduleTime = DateTime.now();
String myQuote = "No quote yet";

// get affirmation quote
Future getAffirmationQuote() async {
  var response = await http.get(Uri.https('affirmations.dev'));
  var jsonData = jsonDecode(response.body);
  final quote = jsonData['affirmation'];

  myQuote = quote;
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int myIndex = 0;
  List<Widget> widgetList = [
    HomePage(),
    JournalPage(),
    LikesPage(),
    SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Journal'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Likes'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}


