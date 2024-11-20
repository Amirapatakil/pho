import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';

void saveTask(
    {required String? description,
    required String? category,
    required int? budget}) async {
  var taskBox = Hive.box<Task>('tasks');
  await taskBox.clear();
  var newTask =
      Task(description: description, category: category, budget: budget);
  await taskBox.add(newTask);

  var tasks = taskBox.values.toList();
  for (var task in tasks) {
    ('Description: ${task.description}, Category: ${task.category}, Budget: ${task.budget}');
  }
}

void deleteTask(int index) async {
  var taskBox = Hive.box<Task>('tasks');

  // Удаление задачи по индексу
  await taskBox.deleteAt(index);

  // Печать всех задач после удаления
  var tasks = taskBox.values.toList();
  for (var task in tasks) {
    log('Description: ${task.description}, Category: ${task.category}, Budget: ${task.budget}');
  }
}
