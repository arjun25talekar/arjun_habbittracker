import 'package:arjun_habbittracker/state/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(habit.name),
        subtitle: Text('Progress: ${habit.progress}/${habit.frequency}'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            context.push('/details', extra: habit);
          },
        ),
      ),
    );
  }
}
