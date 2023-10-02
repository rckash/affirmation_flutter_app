import 'package:affirmation_flutter_app/util/journal_entry_tile.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {

  // list of journal entries
  List journalEntryList = [
    ['Wake up'],
    ['Cook breakfast'],
    ['Eat breakfast']
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: journalEntryList.length,
        itemBuilder: (context, index) {
          return JournalEntryTile(
            taskName: journalEntryList[index][0],
          );
        },
      ),
    );
  }
}
