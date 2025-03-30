import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stackfood_multivendor/common/classes/text_style.dart';
import 'package:stackfood_multivendor/common/widgets/custom_title_appbar.dart';
import 'package:stackfood_multivendor/common/widgets/custum_leading.dart';
import 'package:stackfood_multivendor/features/help/widgets/custom_call_container.dart';
import 'package:stackfood_multivendor/util/images.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 318.h,
                width: 390.w,
                // alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Color(0xFF7C0631),
                ),
                child: Column(
                  children: [
                    Row(
                      spacing: MediaQuery.of(context).size.width / 3.5,
                      children: [
                        CustomLeading(
                          isHelp: Colors.white,
                        ),
                        CustomTitleAppBar(
                          title: "Help & Support",
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 114.h),
                    Text(
                      "How can i help you?",
                      style: AppTextStyle.textStyle(
                        appFontSize: 16.sp,
                        appFontHeight: 19.36.sp,
                        appFontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: -150,
                child: Container(
                  decoration: BoxDecoration(),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 191.h,
                        width: 310.w,
                        padding: EdgeInsets.only(bottom: 20.h),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 4.0,
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomCallContainer(),
                            CustomCallContainer(),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -60.h,
                        child: Container(
                          height: 120.h,
                          width: 277.w,
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
                              Image.asset(Images.locationIcon2),
                              Text(
                                "1234 Elm Street, Apt 5B, Springfield, IL 62704, USA",
                                style: AppTextStyle.textStyle(
                                  appFontSize: 10.sp,
                                  appFontHeight: 12.1.sp,
                                  appFontWeight: FontWeight.w300,
                                  color: Color(0xFF7D7D7D),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
