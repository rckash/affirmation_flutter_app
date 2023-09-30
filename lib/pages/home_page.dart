import 'package:affirmation_flutter_app/pages/main_scaffold.dart';
import 'package:affirmation_flutter_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DatePickerTxt(),
                  const ScheduleBtn(),
                ],
              ),
            ),
            Flexible(
                flex: 2,
                child: Container(
                  color: Colors.teal,
                  child: Center(
                  child: FutureBuilder(
                      future: getAffirmationQuote(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            myQuote,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }
                  ),
                  ),
                )
            )
          ],
        ),
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

