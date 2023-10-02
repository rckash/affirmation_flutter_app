import 'package:hive_flutter/hive_flutter.dart';

class JournalEntryDatabase {
  List journalEntryList = [];
  
  // reference the hive box
  final _journalBox = Hive.box('journalBox');

  // run method if 1st time ever opening this app
  void createInitialData() {
    journalEntryList = [
      ['I wasn\'t on top condition but I still did my best today'],
      ['Today was rough but I did not give up!'],
    ];
  }

  void loadData() {
    journalEntryList = _journalBox.get("JOURNALENTRYLIST");
  }

  void updateDatabase() {
    _journalBox.put("JOURNALENTRYLIST", journalEntryList);
  }
  
}