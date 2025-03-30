import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:stackfood_multivendor/common/classes/text_style.dart';
import 'package:stackfood_multivendor/common/classes/text_style.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/util/images.dart';

class DetailsRestaurantScreen extends StatelessWidget {
  const DetailsRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyRestaurantController());
    return GetBuilder<MyRestaurantController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Column(
              children: [
                Container(
                  height: 206.h,
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        Images.logoFoods,
                      ),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 16.w,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6.r),
                            child: Image.asset(
                              Images.logoFoods,
                              height: 41.h,
                              width: 60.w,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4.h,
                            children: [
                              Text(
                                "Restaurant",
                                style: AppTextStyle.textStyle(
                                  appFontSize: 12.sp,
                                  appFontWeight: FontWeight.w700,
                                  appFontHeight: 14.52.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "1234 Elm Street, Apt 5B",
                                style: AppTextStyle.textStyle(
                                  appFontSize: 10.sp,
                                  appFontWeight: FontWeight.w400,
                                  appFontHeight: 12.1.sp,
                                  color: Colors.grey.withOpacity(0.59),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            weight: 10.w,
                            size: 10.sp,
                            color: Color(0xffFFC107),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "4.0",
                            style: AppTextStyle.textStyle(
                              appFontSize: 10.sp,
                              appFontWeight: FontWeight.w400,
                              appFontHeight: 12.1.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "2 rating",
                            style: AppTextStyle.textStyle(
                              appFontSize: 10.sp,
                              appFontWeight: FontWeight.w400,
                              appFontHeight: 12.1.sp,
                              color: Colors.black.withOpacity(0.50),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      ...List.generate(controller.words.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectTitle(index);
                          },
                          child: Container(
                            width: 179.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              //horizontal: 85.w,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: controller.currentIndex == index
                                      ? Color(0xff7C0631)
                                      : Colors.transparent,
                                  width: 1.w,
                                ),
                              ),
                            ),
                            child: Text(
                              controller.words[index],
                              style: AppTextStyle.textStyle(
                                appFontSize: 12.sp,
                                appFontWeight: FontWeight.w400,
                                appFontHeight: 14.52.sp,
                                color: controller.currentIndex == index
                                    ? Color(0xff7C0631)
                                    : Colors.black.withOpacity(0.50),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                if (controller.currentIndex == 0)
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return Container(
                          height: 120.h,
                          width: 358.w,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.w,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 190.w,
                                //padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "pasta",
                                      style: AppTextStyle.textStyle(
                                        appFontSize: 16.sp,
                                        appFontWeight: FontWeight.w400,
                                        appFontHeight: 19.36.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Pasta with pink sauce is a creamy, tomato-based dish that blends marinara and heavy cream, resulting in a rich, velvety sauce with a....",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: AppTextStyle.textStyle(
                                        appFontSize: 10.sp,
                                        appFontWeight: FontWeight.w400,
                                        appFontHeight: 12.1.sp,
                                        color: Colors.black.withOpacity(0.71),
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      "\$ 223",
                                      style: AppTextStyle.textStyle(
                                        appFontSize: 14.sp,
                                        appFontWeight: FontWeight.w600,
                                        appFontHeight: 16.94.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                height: 104.h,
                                //margin: EdgeInsets.only(right: 4.w),
                                width: 123.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  image: DecorationImage(
                                    image: AssetImage(Images.details_Res),
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 31.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.22),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(6.r),
                                      bottomLeft: Radius.circular(6.r),
                                    ),
                                  ),
                                  child: Text(
                                    "5 remaining",
                                    style: AppTextStyle.textStyle(
                                      appFontSize: 10.sp,
                                      appFontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      appFontHeight: 12.1.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
