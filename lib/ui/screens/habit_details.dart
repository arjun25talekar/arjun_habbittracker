import 'package:arjun_habbittracker/state/hive_model.dart';
import 'package:arjun_habbittracker/state/hive_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitDetailsScreen extends ConsumerWidget {
  final Habit habit;

  const HabitDetailsScreen({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteHabit(context, ref);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Habit: ${habit.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Target Frequency: ${habit.frequency} times per day'),
            const SizedBox(height: 10),
            Text('Progress: ${habit.progress}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showUpdateDialog(context, ref);
              },
              child: const Text('Update Habit'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteHabit(BuildContext context, WidgetRef ref) {
    ref.read(habitProvider.notifier).deleteHabit(habit);

    // Navigate back and show a snackbar
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${habit.name} deleted successfully!')),
    );
  }

  void _showUpdateDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: habit.name);
    final frequencyController =
        TextEditingController(text: habit.frequency.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Habit Name'),
              ),
              TextField(
                controller: frequencyController,
                decoration:
                    const InputDecoration(labelText: 'Target Frequency'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () => Navigator.pop(context),
          //     child: const Text('Cancel'),
          //   ),
          //   TextButton(
          //     onPressed: () {
          //       final updatedName = nameController.text.trim();
          //       final updatedFrequency =
          //           int.tryParse(frequencyController.text) ?? habit.frequency;

          //       if (updatedName.isNotEmpty) {
          //         final updatedHabit = habit.copyWith(
          //           name: updatedName,
          //           frequency: updatedFrequency,
          //         );

          //         ref.read(habitProvider.notifier).updateHabit(updatedHabit);

          //         Navigator.pop(context);

          //         // Show a snackbar after update
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //               content: Text('${habit.name} updated successfully!')),
          //         );
          //       }
          //     },
          //     child: const Text('Update'),
          //   ),
          // ],
        );
      },
    );
  }
}
