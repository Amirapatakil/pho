import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/duty/widgets/close_tasks.dart';
import 'package:philantropic_offering_app/duty/widgets/open_tasks.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';

class DutyScreen extends StatefulWidget {
  const DutyScreen({super.key});

  @override
  State<DutyScreen> createState() => _DutyScreenState();
}

class _DutyScreenState extends State<DutyScreen> {
  bool isOpenTasks = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Row(children: [
          Text(
            '#all-tasks',
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w500,
              color: PHOColor.white,
            ),
          ),
        ]),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Container(
            height: 32.h,
            width: 343.w,
            decoration: BoxDecoration(
              color: PHOColor.taskUnSelected.withOpacity(0.24),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isOpenTasks = true;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: isOpenTasks
                          ? PHOColor.blue4674FF
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text("Open tasks",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: PHOColor.white,
                        )),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isOpenTasks = false;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: !isOpenTasks
                          ? PHOColor.blue4674FF
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text("Closed tasks",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: PHOColor.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: isOpenTasks
                  ? const BuildOpenTasksView()
                  : const BuildClosedTasksView(),
            ),
          )
        ],
      ),
    );
  }
}
