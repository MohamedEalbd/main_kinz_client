import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackfood_multivendor/common/classes/text_style.dart';
import 'package:stackfood_multivendor/util/images.dart';

class CustomCallContainer extends StatelessWidget {
  const CustomCallContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.h,
      width: 94.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          width: 1.w,
          color: Color(0xFF7C0631).withOpacity(0.34),
        ),
      ),
      child: Column(
        spacing: 8.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.callIcon2),
          Text(
            "(555) 123-4567",
            style: AppTextStyle.textStyle(
              appFontSize: 10.sp,
              appFontHeight: 12.1.sp,
              appFontWeight: FontWeight.w300,
              color: Color(0xFF7D7D7D),
            ),
          )
        ],
      ),
    );
  }
}
