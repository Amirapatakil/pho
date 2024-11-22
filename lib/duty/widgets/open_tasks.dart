import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';

class BuildOpenTasksView extends StatefulWidget {
  const BuildOpenTasksView({super.key});

  @override
  State<BuildOpenTasksView> createState() => _BuildOpenTasksViewState();
}

class _BuildOpenTasksViewState extends State<BuildOpenTasksView> {
  ValueNotifier<List<Task>> uncompletedTasksNotifier =
      ValueNotifier<List<Task>>([]);
  final Box<Task> box = Hive.box<Task>('tasks');
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _deleteTask(int index) {
    final updatedTasks = List<Task>.from(uncompletedTasksNotifier.value);
    updatedTasks.removeAt(index);
    uncompletedTasksNotifier.value = updatedTasks;
    box.deleteAt(index);
  }

  Widget _removedItem(Task item, Animation<double> animation) {
    print('build');
    final task = item;
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.h),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: PHOColor.green,
                width: 1,
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
                        width: 50.w, height: 50.h, 'assets/images/check.png'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _completeTask(int index) {
    final task = uncompletedTasksNotifier.value[index];
    final updatedTasks = List<Task>.from(uncompletedTasksNotifier.value);

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _removedItem(updatedTasks[index], animation),
      duration: const Duration(seconds: 1),
    );
    Future.delayed(const Duration(seconds: 1), () {
      updatedTasks.removeAt(index);
      uncompletedTasksNotifier.value = updatedTasks;
      setState(() {
        task.isCompleted = true;
        Hive.box<Task>('tasks').putAt(index, task);
      });
    });
  }

  void sortOpenTask() {
    final tasks =
        box.values.where((task) => task.isCompleted ?? false).toList();
    uncompletedTasksNotifier.value = tasks;

    List<Task> hiveList = box.values.toList();
    List<Task> list = [];
    for (int i = 0; hiveList.length > i; i++) {
      if (hiveList[i].isCompleted == false) {
        list.add(hiveList[i]);
      }
    }
    uncompletedTasksNotifier.value = list;
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

  @override
  Widget build(BuildContext context) {
    sortOpenTask();
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
                    if (index < 0 || index >= uncompletedTasks.length) {
                      return SizedBox.shrink(); // Возвращаем пустой виджет
                    }
                    final task = uncompletedTasks[index];
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
                        child: SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0),
                            ).chain(CurveTween(curve: Curves.easeInOut)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _completeTask(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
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
                                          color:
                                              PHOColor.white.withOpacity(0.3)),
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
                        ),
                      ),
                    );
                  },
                );
        });
  }
}
