import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';

class BuildOpenTasksView extends StatefulWidget {
  const BuildOpenTasksView({super.key});

  @override
  State<BuildOpenTasksView> createState() => _BuildOpenTasksViewState();
}

class _BuildOpenTasksViewState extends State<BuildOpenTasksView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ValueNotifier<List<Task>> uncompletedTasksNotifier;
  final box = Hive.box<Task>('tasks');

  @override
  void initState() {
    super.initState();
    uncompletedTasksNotifier = ValueNotifier<List<Task>>([]);
    _loadTasks();
    print('initState');
  }

  void _loadTasks() {
    setState(() {
      final tasks =
          box.values.where((task) => task.isCompleted == false).toList();
      uncompletedTasksNotifier.value = _removeDuplicates(tasks);
    });
  }

  void _completeTask(int index) {
    final task = uncompletedTasksNotifier.value[index];
    setState(() {
      task.isCompleted = true;
      Hive.box<Task>('tasks').putAt(index, task);
      uncompletedTasksNotifier.value.removeAt(index);
    });

    _loadTasks();
  }

  List<Task> _removeDuplicates(List<Task> tasks) {
    final seen = <String>{};
    return tasks.where((task) {
      final taskKey = '${task.category ?? ""}-${task.description ?? ""}';
      if (seen.contains(taskKey)) {
        return false;
      } else {
        seen.add(taskKey);
        return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Task>>(
        valueListenable: uncompletedTasksNotifier,
        builder: (context, uncompletedTasks, child) {
          return uncompletedTasks.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "No good deed generated yet ;(",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w400,
                        color: PHOColor.white.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 142.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60.w),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Text(
                              "Tap, to generate \ngood deed for today",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: PHOColor.white.withOpacity(0.3),
                              ),
                            ),
                            Image.asset('assets/images/vector.png')
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : AnimatedList(
                  key: _listKey,
                  initialItemCount: uncompletedTasks.length,
                  itemBuilder: (context, index, animation) {
                    final task = uncompletedTasks[index];
                    return SlideTransition(
                      position: animation.drive(
                        Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
                            .chain(CurveTween(curve: Curves.easeOut)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 10.h,
                        ),
                        child: GestureDetector(
                          onTap: () => _completeTask(index),
                          child: Container(
                            height: 175.h,
                            width: 343.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: task.isCompleted ?? false
                                      ? PHOColor.green
                                      : PHOColor.white.withOpacity(0.3),
                                  width: 1.w,
                                ),
                                color: PHOColor.tasksColor,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.category ?? "No category",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: PHOColor.white.withOpacity(0.3)),
                                  ),
                                  Text(
                                    task.description ?? "No description",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: PHOColor.white),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '\$${task.budget ?? 0}',
                                          style: TextStyle(
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.w400,
                                              color: PHOColor.white),
                                        ),
                                      ),
                                      Image.asset(
                                        width: 50.w,
                                        height: 50.h,
                                        task.isCompleted ?? false
                                            ? 'assets/images/check.png'
                                            : 'assets/images/uncheck.png',
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        });
  }
}
