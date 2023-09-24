import 'dart:convert';
import 'package:affirmation_flutter_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
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
        child: Column(
          children: [
            const DatePickerTxt(),
            const ScheduleBtn(),
            FutureBuilder(
                future: getAffirmationQuote(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(myQuote);
                  } else {
                    return const CircularProgressIndicator();
                    }
                  }
            ),
          ],
          )
        ),
    );
  }
}

class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({super.key});

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => scheduleTime = date,
          onConfirm: (date) {}
        );
      },
      child: const Text(
        "Select Date Time",
        style: TextStyle(color: Colors.red)
        ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule Notification'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
          title: 'Scheduled Notification',
          body: '$scheduleTime',
          scheduleNotificationDateTime: scheduleTime
        );
      },
    );
  }
}

