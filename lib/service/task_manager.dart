import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';

void saveTask({
  required String? description,
  required String? category,
  required int? budget,
  required BuildContext context,
}) async {
  var taskBox = Hive.box<Task>('tasks');
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<Task> tasks = taskBox.values.toList();

  var newTask = Task(
      description: description,
      category: category,
      budget: budget,
      date: formattedDate);
  await taskBox.add(newTask);

  tasks = taskBox.values.toList();
  for (var task in tasks) {
    ('Description: ${task.description}, Category: ${task.category}, Budget: ${task.budget}, Date: ${task.date}');
  }
}
