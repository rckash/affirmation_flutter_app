import 'package:affirmation_flutter_app/data/database.dart';
import 'package:affirmation_flutter_app/util/dialog_box.dart';
import 'package:affirmation_flutter_app/util/journal_entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  // reference the hive box
  final _journalBox = Hive.box('journalBox');
  JournalEntryDatabase db = JournalEntryDatabase();

  @override
  void initState() {
    
    // if 1st time ever opening the app, then create default data
    if(_journalBox.get("JOURNALENTRYLIST") == null) {
      db.createInitialData();
    } else {
      // if data already exists
      db.loadData();
    }
    
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();
  
  void saveNewTask() {
    setState(() {
      db.journalEntryList.add([ _controller.text ]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewEntry() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        }
    );
  }

  void deleteEntry(int index) {
    setState(() {
      db.journalEntryList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewEntry,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.journalEntryList.length,
        itemBuilder: (context, index) {
          return JournalEntryTile(
            taskName: db.journalEntryList[index][0],
            deleteFunction: (context) => deleteEntry,
          );
        },
      ),
    );
  }
}
