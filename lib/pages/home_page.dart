import 'package:affirmation_flutter_app/pages/main_scaffold.dart';
import 'package:affirmation_flutter_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_fonts/google_fonts.dart';

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
                flex: 8,
                child: Container(
                  color: Colors.indigo.shade700,
                  child: Center(
                  child: FutureBuilder(
                      future: getAffirmationQuote(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Text(
                              myQuote,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        }
                      }
                  ),
                  ),
                )
            ),
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.indigo.shade100,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DatePickerTxt(),
                        ScheduleBtn(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
        style: TextStyle(
          fontSize: 16
        ),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        'Schedule Notification',
        style: GoogleFonts.dmSans(
            fontSize: 16
        ),
      ),
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

