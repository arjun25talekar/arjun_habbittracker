import 'package:arjun_habbittracker/state/hive_model.dart';
import 'package:arjun_habbittracker/state/hive_provider.dart';
import 'package:arjun_habbittracker/ui/widgets/habit_card.dart';
import 'package:arjun_habbittracker/ui/widgets/motivational_quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/text_styles.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Progress"),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with daily overview
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const MotivationalQuote(),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const MotivationalQuote(),
                  const SizedBox(height: 20),
                  Text(
                    "Habits Completed: ${habits.where((h) => h.progress >= h.frequency).length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // Habit Overview List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HabitCard(habit: habits[index]);
              },
              childCount: habits.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHabitDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController frequencyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Habit',
            style: AppTextStyle.blackBold14,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Habit Name',
                ),
              ),
              TextField(
                controller: frequencyController,
                decoration:
                    const InputDecoration(labelText: 'Target Frequency'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyle.blackBold16,
              ),
            ),
            TextButton(
              onPressed: () {
                final habitName = nameController.text;
                final frequency = int.tryParse(frequencyController.text) ?? 1;

                if (habitName.isNotEmpty) {
                  ref.read(habitProvider.notifier).addHabit(
                        Habit(
                          name: habitName,
                          frequency: frequency,
                          progress: 0,
                          category: 'Uncategorized',
                        ),
                      );
                  Navigator.pop(context);

                  // Show a toast when a habit is added
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      'Habit added successfully!',
                      style: AppTextStyle.blackBold16,
                    )),
                  );
                }
              },
              child: Text(
                'Add Habit',
                style: AppTextStyle.blackBold18,
              ),
            ),
          ],
        );
      },
    );
  }
}
