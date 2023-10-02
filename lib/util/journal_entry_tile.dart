import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class JournalEntryTile extends StatelessWidget {
  final String taskName;
  Function(BuildContext)? deleteFunction;

  JournalEntryTile({
    super.key,
    required this.taskName,
    required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  taskName,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
