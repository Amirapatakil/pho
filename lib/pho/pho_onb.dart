import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:philantropic_offering_app/pho/pho_botom.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/pho/pho_moti.dart';

class PHOBORDing extends StatefulWidget {
  const PHOBORDing({super.key});

  @override
  State<PHOBORDing> createState() => _PHOBORDingState();
}

class _PHOBORDingState extends State<PHOBORDing> {
  final PageController _controller = PageController();
  int introIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                introIndex = index;
              });
            },
            children: const [],
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildIndicators(),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: PHOMotionButt(
                    onPressed: () {
                      if (introIndex < 2) {
                        _controller.animateToPage(
                          introIndex + 1,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PHOBotBar(),
                          ),
                          (protected) => false,
                        );
                      }
                    },
                    child: Container(
                      height: 46.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: PHOColor.blue4674FF,
                        borderRadius: BorderRadius.circular(56.r),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: PHOColor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        bool isActive = introIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 8.w : 6.w,
          height: isActive ? 8.h : 6.h,
          decoration: BoxDecoration(
            color: isActive ? PHOColor.white : PHOColor.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      }),
    );
  }
}
