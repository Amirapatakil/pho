import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:philantropic_offering_app/duty/duty_screen.dart';
import 'package:philantropic_offering_app/generate_ideas/list_tasks.dart';
import 'package:philantropic_offering_app/nastroy/nastroy_screen.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/pho/pho_moti.dart';

class PHOBotBarState extends State<PHOBotBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
      floatingActionButton: Column(
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListTasks()));
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
