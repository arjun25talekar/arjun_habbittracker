import 'package:arjun_habbittracker/state/hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super([]);

  void addHabit(Habit habit) {
    state = [...state, habit];
  }

  void updateHabit(Habit updatedHabit) {
    state = [
      for (final habit in state)
        if (habit.name == updatedHabit.name) updatedHabit else habit,
    ];
  }

  void deleteHabit(Habit habitToDelete) {
    state = state.where((habit) => habit != habitToDelete).toList();
  }
}

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>(
  (ref) => HabitNotifier(),
);
