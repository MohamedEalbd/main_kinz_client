import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/common/models/restaurant_model.dart';
import 'package:stackfood_multivendor/features/cart/controllers/cart_controller.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/helper/price_converter.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';

import '../../../util/images.dart';
import '../../splash/controllers/theme_controller.dart';

class ExtraPackagingWidget extends StatelessWidget {
  final CartController cartController;
  const ExtraPackagingWidget({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(builder: (restaurantController) {

      Restaurant? restaurant = restaurantController.restaurant;

      return (restaurant != null && restaurant.isExtraPackagingActive! && restaurant.extraPackagingAmount != null && restaurant.extraPackagingAmount != 0 && !restaurant.extraPackagingStatusIsMandatory!) ? Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 1))],
        ),
        child: Row(children: [

          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: cartController.needExtraPackage,
            onChanged: (bool? isChecked) {
              cartController.toggleExtraPackage();
            },
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),

          Text('need_extra_packaging'.tr, style: robotoMedium),
          const Spacer(),

          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5.w,
            children: [
              Text(PriceConverter.convertPrice(restaurantController.restaurant?.extraPackagingAmount), style: robotoMedium),
              GetBuilder<ThemeController>(
                  builder: (themeController) {
                    return  SvgPicture.asset(Images.myMoney,height: 20.h,width: 20.w,color:themeController.darkTheme? Colors.white:Colors.grey);
                  }
              ),
            ],
          ),

        ]),
      ) : const SizedBox();
    });
  }
}
