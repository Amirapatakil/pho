import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/pho/pho_textstyle.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  final List<Map<String, dynamic>> tasks = [
    {
      'budget': 5,
      'category': 'Care for loved ones',
      'description': 'Send a heartfelt text to a loved one.'
    },
    {
      'budget': 10,
      'category': 'Strangers',
      'description': 'Buy a coffee for someone in need.'
    },
    {
      'budget': 20,
      'category': 'Animals',
      'description': 'Donate food to a pet shelter.'
    },
    {
      'budget': 30,
      'category': 'Charity shopping',
      'description': 'Buy a gift for a charity auction.'
    },
  ];

  int? selectedBudget = 5;
  String? selectedCategory = 'Care for loved ones';
  String? randomTask;
  bool showSecondContainer = false;

  void selectRandomTask(String category) {
    var filteredTasks = tasks
        .where((task) =>
            task['budget'] == selectedBudget && task['category'] == category)
        .toList();

    if (filteredTasks.isNotEmpty) {
      var random = Random();
      var randomTaskIndex = random.nextInt(filteredTasks.length);
      setState(() {
        randomTask = filteredTasks[randomTaskIndex]['description'];
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
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 12, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: showSecondContainer ? 0.5 : 1.0,
                  child: Container(
                    height: 183,
                    width: 343,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: PHOColor.tasksColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'The amount for today' 's good deed',
                              style: PHOTextstyle.s14w400.copyWith(
                                  color: PHOColor.white.withOpacity(0.3)),
                            ),
                          ],
                        ),
                        if (selectedBudget != null)
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('\$${selectedBudget}',
                                style: PHOTextstyle.s50w400),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildBudgetButton(5),
                            _buildBudgetButton(10),
                            _buildBudgetButton(20),
                            _buildBudgetButton(30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (showSecondContainer)
              Container(
                height: 209,
                width: 343,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: PHOColor.tasksColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Select a category for your good deed',
                            style: PHOTextstyle.s14w400.copyWith(
                                color: PHOColor.white.withOpacity(0.3)),
                          ),
                        ],
                      ),
                      if (selectedBudget != null)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('\$${selectedBudget}',
                              style: PHOTextstyle.s50w400),
                        ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCategoryButton('Care for loved ones'),
                              const SizedBox(
                                width: 10,
                              ),
                              _buildCategoryButton('Animals'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showSecondContainer = true;
                });
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetButton(int budget) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: PHOColor.blue4674FF),
        onPressed: () {
          setState(() {
            selectedBudget = budget;
          });
        },
        child: Text(
          '\$$budget',
          style: PHOTextstyle.s16w400.copyWith(color: PHOColor.white),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: PHOColor.blue4674FF),
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Text(category),
    );
  }
}