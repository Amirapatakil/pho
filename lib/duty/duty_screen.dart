import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/pho/pho_dimens.dart';
import 'package:philantropic_offering_app/pho/pho_textstyle.dart';

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
          const SizedBox(
            height: PHODimens.smallPadding,
          ),
          Container(
            height: PHODimens.tasksheight,
            width: PHODimens.taskswidth,
            decoration: BoxDecoration(
              color: PHOColor.taskUnSelected.withOpacity(0.24),
              borderRadius: BorderRadius.circular(PHODimens.tasksradius),
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
                        style: PHOTextstyle.s13w600
                            .copyWith(color: PHOColor.white)),
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
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text("Closed tasks",
                        style: PHOTextstyle.s13w600
                            .copyWith(color: PHOColor.white)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child:
                  isOpenTasks ? _buildOpenTasksView() : _buildClosedTasksView(),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildOpenTasksView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text("No good deed generated yet ;(",
          textAlign: TextAlign.center,
          style: PHOTextstyle.s40w400
              .copyWith(color: PHOColor.white.withOpacity(0.3))),
      const SizedBox(
        height: PHODimens.largePadding,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 80),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              Text("Tap, to generate \ngood deed for today",
                  textAlign: TextAlign.center,
                  style: PHOTextstyle.s14w700
                      .copyWith(color: PHOColor.white.withOpacity(0.3))),
              // Image.asset('assets/images/vector.png')
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildClosedTasksView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text("No good deed generated yet ;(",
          textAlign: TextAlign.center,
          style: PHOTextstyle.s40w400
              .copyWith(color: PHOColor.white.withOpacity(0.3))),
      const SizedBox(
        height: PHODimens.largePadding,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 80),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              Text("Tap, to generate \ngood deed for today",
                  textAlign: TextAlign.center,
                  style: PHOTextstyle.s14w700
                      .copyWith(color: PHOColor.white.withOpacity(0.3))),
              // Image.asset('assets/images/vector.png')
            ],
          ),
        ),
      ),
    ],
  );
}
