import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String? description;

  @HiveField(1)
  final String? category;

  @HiveField(2)
  final int? budget;

  @HiveField(3)
  bool? isCompleted = false;

  Task(
      {required this.description,
      required this.category,
      required this.budget,
      this.isCompleted = false});
}

@HiveType(typeId: 1)
class Date {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final bool hasGeneratedTask;

  Date({required this.date, required this.hasGeneratedTask});
}
