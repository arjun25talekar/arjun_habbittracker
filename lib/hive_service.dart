import 'package:arjun_habbittracker/state/hive_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  static Future<void> saveHabit(Habit habit) async {
    final box = await Hive.openBox<Habit>('habits');
    box.add(habit);
  }

  static Future<List<Habit>> fetchHabits() async {
    final box = await Hive.openBox<Habit>('habits');
    return box.values.toList();
  }
}
