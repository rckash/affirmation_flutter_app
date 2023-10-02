import 'package:flutter/material.dart';

class JournalEntryTile extends StatelessWidget {
  final String taskName;

  const JournalEntryTile({
    super.key,
    required this.taskName
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(taskName),
      ),
    );
  }
}
