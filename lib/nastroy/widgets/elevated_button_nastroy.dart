import 'package:flutter/material.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonNastroy extends StatelessWidget {
  const ElevatedButtonNastroy(
      {super.key, required this.text, this.iconPath, this.onPressed});
  final String text;
  final String? iconPath;
  final void Function()? onPressed;

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
          width: 343.w,
          child: Row(
            children: [
              Image(image: AssetImage(iconPath!)),
              SizedBox(
                width: 16.w,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: PHOColor.white,
                ),
              )
            ],
          ),
        ));
  }
}
