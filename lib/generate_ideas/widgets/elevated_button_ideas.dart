import 'package:flutter/material.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonIdeas extends StatelessWidget {
  const ElevatedButtonIdeas({
    super.key,
    required this.text,
    this.iconPath,
    this.onPressed,
    required this.isFinalSelection,
  });
  final String text;
  final String? iconPath;
  final void Function()? onPressed;
  final bool isFinalSelection;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: PHOColor.blue4674FF,
          foregroundColor: PHOColor.white,
        ),
        onPressed: onPressed,
        child: SizedBox(
          height: 80.h,
          width: isFinalSelection ? 243.w : 243.w,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: PHOColor.white,
              ),
            ),
          ),
        ));
  }
}
