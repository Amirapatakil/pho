import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';

class BuildClosedTasksView extends StatefulWidget {
  const BuildClosedTasksView({super.key});

  @override
  State<BuildClosedTasksView> createState() => _BuildClosedTasksViewState();
}

class _BuildClosedTasksViewState extends State<BuildClosedTasksView> {
  ValueNotifier<List<Task>> completedTasksNotifier =
      ValueNotifier<List<Task>>([]);
  List<Task> completedTasks = [];
  final box = Hive.box<Task>('tasks');

  void getList() {
    completedTasks.clear();
    List<Task> hiveList = box.values.toList();
    List<Task> list = [];
    for (int i = 0; hiveList.length > i; i++) {
      if (hiveList[i].isCompleted == true) {
        list.add(hiveList[i]);
      }
    }
    completedTasks = list;
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              'Delete generated deed',
              style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: PHOColor.white),
            ),
            content: Text(
              'If you delete generated deed, you won’t be able to restore it back',
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: PHOColor.white),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: PHOColor.blue4674FF),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  'Delete',
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: PHOColor.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteTask(index);
                },
              ),
            ],
          );
        });
  }

  void _deleteTask(int index) {
    completedTasks.removeAt(index);
    completedTasksNotifier.value = List.from(completedTasks);
    box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    getList();
    return ValueListenableBuilder<List<Task>>(
        valueListenable: completedTasksNotifier,
        builder: (context, uncompletedTasks, child) {
          return completedTasks.isEmpty
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
              : ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 10.h,
                      ),
                      child: Slidable(
                        key: ValueKey(task),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            CustomSlidableAction(
                                onPressed: (context) =>
                                    _showDeleteConfirmationDialog(index),
                                padding: EdgeInsets.zero,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  height: 175.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: PHOColor.red,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child:
                                      Image.asset('assets/images/delete.png'),
                                )),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: task.isCompleted == true
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
                                      task.isCompleted == true
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
                    );
                  },
                );
        });
  }
}
