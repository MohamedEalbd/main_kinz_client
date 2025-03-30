import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/splash/controllers/theme_controller.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/dimensions.dart';
import '../util/images.dart';

class PriceConverter {
  static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, bool isVariation = false,bool isSpan = false,bool isDiscount = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount' && !isVariation) {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }

    int digitAfterDecimalPoint = Get.find<SplashController>().configModel!.digitAfterDecimalPoint ?? 2;

    int tempPrice = price!.floor();
    if((price - tempPrice) == 0) {
      digitAfterDecimalPoint = 0;
    }

    bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
    return '${isRightSide ? '' : ''}' //${Get.find<SplashController>().configModel!.currencySymbol!}
        '${(toFixed(price)).toStringAsFixed(forDM ? 0 : digitAfterDecimalPoint)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${isRightSide ? ' ' : ''}';//${Get.find<SplashController>().configModel!.currencySymbol!}
    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   spacing: 5.w,
    //   children: [
    //     Text(
    //       result,
    //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,decoration: isDiscount? TextDecoration.lineThrough: null), textDirection: TextDirection.ltr,
    //     ),
    //     GetBuilder<ThemeController>(
    //         builder: (themeController) {
    //           return  isRightSide? SvgPicture.asset(Images.myMoney,height: 20.h,width: 20.w,color:themeController.darkTheme? Colors.white:Colors.grey): SizedBox();
    //         }
    //     ),
    //   ],
    // );
  }

  static Widget convertAnimationPrice(double? price, {double? discount, String? discountType, bool forDM = false, TextStyle? textStyle}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 5.w,
        children: [
          GetBuilder<ThemeController>(
              builder: (themeController) {
                return  isRightSide? SvgPicture.asset(Images.myMoney,height: 20.h,width: 20.w,color:themeController.darkTheme? Colors.white:Colors.grey): SizedBox();
              }
          ),
          Text("${toFixed(price!)}",style: textStyle ?? robotoMedium,),

        ],
      ),

      // AnimatedFlipCounter(
      //   duration: const Duration(milliseconds: 500),
      //   value: toFixed(price!),
      //   textStyle: textStyle ?? robotoMedium,
      //   fractionDigits: forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!,
      //   prefix:isRightSide ? '' : Get.find<SplashController>().configModel!.currencySymbol!,
      //   suffix: isRightSide ? Get.find<SplashController>().configModel!.currencySymbol! : '',
      //
      // ),
    );
  }


  static double? convertWithDiscount(double? price, double? discount, String? discountType, {bool isVariation = false}) {
    if(discountType == 'amount' && !isVariation) {
      price = price! - discount!;
    }else if(discountType == 'percent') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double? discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount! * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount! / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : Get.find<SplashController>().configModel!.currencySymbol} OFF';
  }

  static double toFixed(double val) {
    num mod = power(10, Get.find<SplashController>().configModel!.digitAfterDecimalPoint!);
    return (((val * mod).toPrecision(Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)).floor().toDouble() / mod);
  }

  static int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }

}