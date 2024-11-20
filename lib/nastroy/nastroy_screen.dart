import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/nastroy/widgets/elevated_button_nastroy.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';

class NastroyScreen extends StatelessWidget {
  const NastroyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              '#settings',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
                color: PHOColor.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButtonNastroy(
              iconPath: 'assets/images/locked.png',
              text: 'Privacy Policy',
              onPressed: () {},
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButtonNastroy(
              iconPath: 'assets/images/folder.png',
              text: 'Terms of Use',
              onPressed: () {},
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButtonNastroy(
              iconPath: 'assets/images/arrow.png',
              text: 'Share App',
              onPressed: () {},
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButtonNastroy(
              iconPath: 'assets/images/star.png',
              text: 'Support',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
