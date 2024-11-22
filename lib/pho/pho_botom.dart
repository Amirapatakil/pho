import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:philantropic_offering_app/duty/duty_screen.dart';
import 'package:philantropic_offering_app/generate_ideas/generate_ideas_screen.dart';
import 'package:philantropic_offering_app/nastroy/nastroy_screen.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/pho/pho_moti.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';

class PHOBotBarState extends State<PHOBotBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    void showCustomToast(BuildContext context) {
      FToast fToast = FToast();
      fToast.init(context);

      fToast.showToast(
        toastDuration: const Duration(seconds: 1),
        gravity: ToastGravity.BOTTOM,
        child: Padding(
          padding: EdgeInsets.only(bottom: 85.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: PHOColor.green.withOpacity(0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20.r),
              color: PHOColor.ftoastColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/ftoast.png'),
                SizedBox(width: 12.w),
                Text(
                  "Return tomorrow for a new task.",
                  style: TextStyle(
                      color: PHOColor.green,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Future<bool> isTaskCreatedToday() async {
      var taskBox = Hive.box<Task>('tasks');
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      List<Task> tasks = taskBox.values.toList();
      return tasks.any((task) => task.date == formattedDate);
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ClipRRect(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage(
                'assets/images/botom.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          height: 110.h,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: buildNavItem(
                  0,
                  'assets/icons/btm1.svg',
                  'assets/icons/btm1det.svg',
                  'Tasks',
                ),
              ),
              SizedBox(width: 80.w),
              Expanded(
                child: buildNavItem(
                  1,
                  'assets/icons/btm2.svg',
                  'assets/icons/btm2det.svg',
                  'Settings',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: const BoxDecoration(
                    color: PHOColor.blue4674FF,
                    shape: BoxShape.circle,
                  ),
                  child: FloatingActionButton(
                    onPressed: () async {
                      bool taskCreatedToday = await isTaskCreatedToday();

                      if (taskCreatedToday) {
                        showCustomToast(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GenerateIdeasScreen(),
                          ),
                        );
                      }
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: SvgPicture.asset(
                      'assets/icons/float.svg',
                    ),
                  ),
                ),
                SizedBox(height: 30.w)
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget buildNavItem(
      int index, String iconPath, String activeIconPath, String label) {
    bool isActive = _currentIndex == index;
    return PHOMotionButt(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isActive ? activeIconPath : iconPath,
            width: 30.sp,
            height: 30.sp,
            color: isActive ? PHOColor.white : PHOColor.white.withOpacity(0.2),
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color:
                  isActive ? PHOColor.white : PHOColor.white.withOpacity(0.2),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  final _pages = <Widget>[
    const DutyScreen(),
    const NastroyScreen(),
  ];
}

class PHOBotBar extends StatefulWidget {
  const PHOBotBar({super.key, this.indexScr = 0});
  final int indexScr;

  @override
  State<PHOBotBar> createState() => PHOBotBarState();
}
