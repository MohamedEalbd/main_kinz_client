import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildButtonWidget extends StatelessWidget {
  const BuildButtonWidget(
      {super.key, required this.txt, this.onTap, this.textStyle});
  final String txt;
  final GestureTapCallback? onTap;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.5.h),
        decoration: BoxDecoration(
          color: Color(0xff2B3D16),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          txt,
          style: textStyle == null
              ? TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                )
              : textStyle,
        ),
      ),
    );
  }
}
