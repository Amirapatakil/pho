import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:philantropic_offering_app/generate_ideas/widgets/budget_button.dart';
import 'package:philantropic_offering_app/generate_ideas/widgets/elevated_button_ideas.dart';
import 'package:philantropic_offering_app/generate_ideas/widgets/task_container.dart.dart';
import 'package:philantropic_offering_app/pho/pho_botom.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/pho/pho_textstyle.dart';
import 'package:philantropic_offering_app/generate_ideas/data/list_of_tasks.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';
import 'package:philantropic_offering_app/service/task_manager.dart';

class GenerateIdeasScreen extends StatefulWidget {
  const GenerateIdeasScreen({super.key});

  @override
  State<GenerateIdeasScreen> createState() => _GenerateIdeasScreenState();
}

class _GenerateIdeasScreenState extends State<GenerateIdeasScreen> {
  int? selectedBudget = 5;
  String? selectedCategory = 'Care for loved ones';
  String? randomTask;
  bool showSecondContainer = false;
  bool showThirdContainer = false;
  bool isFinalSelection = false;

  void selectRandomTask(String category) {
    var filteredTasks = tasks
        .where((task) =>
            task['budget'] == selectedBudget && task['category'] == category)
        .toList();

    if (filteredTasks.isNotEmpty) {
      var random = Random();
      var randomTaskIndex = random.nextInt(filteredTasks.length);
      var selectedDescription = filteredTasks[randomTaskIndex]['description'];
      setState(() {
        if (selectedDescription is List<String>) {
          randomTask =
              selectedDescription[random.nextInt(selectedDescription.length)];
        } else if (selectedDescription is String) {
          randomTask = selectedDescription;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PHOColor.splash,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '#add-task',
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w500,
              color: PHOColor.white,
            ),
          ),
        ]),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: showSecondContainer ? 0.5 : 1.0,
                  child: AbsorbPointer(
                    absorbing: showSecondContainer,
                    child: TaskContainer(
                      height: showSecondContainer ? 131.h : 183.h,
                      color: PHOColor.tasksColor,
                      showContainer: showSecondContainer,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'The amount for today' 's good deed',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: PHOColor.white.withOpacity(0.3),
                                ),
                              ),
                            ],
                          ),
                          if (selectedBudget != null)
                            Expanded(
                              child: Text('\$$selectedBudget',
                                  style: TextStyle(
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.w400,
                                      color: PHOColor.white)),
                            ),
                          if (!showSecondContainer)
                            Expanded(
                              child: BudgetSelector(
                                selectedBudget: selectedBudget,
                                onBudgetSelected: (budget) {
                                  setState(() {
                                    selectedBudget = budget;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            if (showSecondContainer)
              Stack(
                children: [
                  Opacity(
                    opacity: showThirdContainer ? 0.5 : 1.0,
                    child: AbsorbPointer(
                      absorbing: showThirdContainer,
                      child: TaskContainer(
                        height: !showThirdContainer ? 209.h : 117.h,
                        color: PHOColor.tasksColor,
                        showContainer: !showSecondContainer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Select a category for your good deed',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: PHOColor.white.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                            if (selectedBudget != null)
                              Text('$selectedCategory',
                                  style: PHOTextstyle.s36w400),
                            if (!isFinalSelection)
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildCategoryButton(
                                          'Care for loved ones'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _buildCategoryButton('Animals'),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildCategoryButton('Strangers'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _buildCategoryButton('Charity shopping'),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 20.h,
            ),
            if (showThirdContainer)
              TaskContainer(
                  height: 153.h,
                  showContainer: showThirdContainer,
                  color: PHOColor.green,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good deed you can do today',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: PHOColor.black.withOpacity(0.3),
                          ),
                        ),
                        Text(
                          randomTask ?? 'No task available',
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w400,
                            color: PHOColor.black,
                            height: 1.0.h,
                          ),
                        ),
                      ],
                    ),
                  )),
            Expanded(child: Container()),
            SizedBox(
              height: 133.h,
            ),
            Row(
              children: [
                if (isFinalSelection == false)
                  Row(
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.r),
                            color: PHOColor.tasksColor),
                        child: IconButton(
                            onPressed: () {
                              if (showSecondContainer == false) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PHOBotBar()));
                              }
                              if (showSecondContainer) {
                                setState(() {
                                  showSecondContainer = false;
                                });
                              }
                              if (showThirdContainer) {
                                setState(() {
                                  showThirdContainer = false;
                                });
                              }
                            },
                            icon: Image.asset('assets/images/arrow_left.png')),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                Expanded(
                  child: ElevatedButtonIdeas(
                    isFinalSelection: isFinalSelection,
                    text: showSecondContainer ? 'Generate deed' : 'Next step',
                    onPressed: () {
                      setState(() {
                        if (!showSecondContainer) {
                          showSecondContainer = true;
                        } else if (!isFinalSelection) {
                          isFinalSelection = true;
                          showThirdContainer = true;
                          selectRandomTask(selectedCategory!);
                        } else {
                          saveTask(
                            category: selectedCategory ?? '',
                            description: randomTask ?? 'No task',
                            budget: selectedBudget ?? 0,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PHOBotBar()));
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, top: 10.h),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r)),
        height: 36.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: selectedCategory == category
                  ? PHOColor.blue4674FF
                  : PHOColor.white.withOpacity(0.1)),
          onPressed: () {
            setState(() {
              selectedCategory = category;
            });
          },
          child: Text(category,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: PHOColor.white)),
        ),
      ),
    );
  }
}
