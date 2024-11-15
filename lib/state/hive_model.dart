import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int frequency;
  @HiveField(2)
  final int progress;
  @HiveField(3)
  final String category;

  Habit(
      {required this.name,
      required this.frequency,
      required this.progress,
      required this.category});
}
