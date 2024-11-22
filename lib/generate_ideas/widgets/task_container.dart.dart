import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskContainer extends StatelessWidget {
  final bool showContainer;
  final Color color;
  final Widget child;
  final double? height;

  const TaskContainer({
    super.key,
    required this.showContainer,
    required this.child,
    required this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      // width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: 24.w,
            top: 24.h,
            bottom: 24.h,
            right: showContainer ? 24.h : 0),
        child: child,
      ),
    );
  }
}
