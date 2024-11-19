import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'widgets/elevated_buttom.dart';

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
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 12, vertical: 16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ElevatedButtom(
              iconPath: 'assets/images/locked.png',
              text: 'Privacy Policy',
            ),
            const SizedBox(
              height: 20,
            ),
            const ElevatedButtom(
              iconPath: 'assets/images/folder.png',
              text: 'Terms of Use',
            ),
            const SizedBox(
              height: 20,
            ),
            const ElevatedButtom(
              iconPath: 'assets/images/arrow.png',
              text: 'Share App',
            ),
            const SizedBox(
              height: 20,
            ),
            const ElevatedButtom(
              iconPath: 'assets/images/star.png',
              text: 'Support',
            )
          ],
        ),
      ),
    );
  }
}
