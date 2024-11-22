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

  @HiveField(4)
  final String? date;

  Task(
      {required this.description,
      required this.category,
      required this.budget,
      this.isCompleted = false,
      required this.date});
}
