import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTitleAppBar extends StatelessWidget {
  const CustomTitleAppBar({super.key, required this.title, this.color});
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: "Inter",
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: color == null ? Color(0xff1E1E1E) : color,
      ),
    );
  }
}
