import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/features/business/domain/models/package_model.dart';
import 'package:stackfood_multivendor/features/business/widgets/curve_clipper_widget.dart';
import 'package:stackfood_multivendor/features/business/widgets/package_widget.dart';
import 'package:stackfood_multivendor/helper/price_converter.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';

import '../../../util/images.dart';
import '../../splash/controllers/theme_controller.dart';

class PackageCardWidget extends StatelessWidget {
  final bool canSelect;
  final Packages packages;
  const PackageCardWidget({super.key, required this.canSelect, required this.packages});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(children: [

        Builder(
          builder: (context) {
            return Container(
              height: 420,
              decoration: BoxDecoration(
                color: canSelect ? const Color(0xff334257) : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                border: Border.all(color: Colors.black12, width: 0.5),
                boxShadow: canSelect ? const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)] : null,
              ),
            );
          }
        ),

        Positioned(
          top: 0, left: 23,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault)),
            child: CustomPaint(
              size: const Size(183, 122),
              painter: RPSCustomPainter(
                color: canSelect ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),

        Positioned(
          top: 30, left: 0, right: 0,
          child: Column(children: [

            Text(
              '${packages.packageName}', textAlign: TextAlign.center,
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: canSelect ? Theme.of(context).cardColor : const Color(0xff334257)),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5.w,
              children: [
                Text(
                  PriceConverter.convertPrice(packages.price),
                  style: robotoBold.copyWith(fontSize: 35, color: canSelect ? Theme.of(context).cardColor : const Color(0xff334257)),
                ),
                GetBuilder<ThemeController>(
                    builder: (themeController) {
                      return  SvgPicture.asset(Images.myMoney,height: 20.h,width: 20.w,color:themeController.darkTheme? Colors.white:Colors.grey);
                    }
                ),
              ],
            ),

            Text('${packages.validity}' 'days'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),

            Divider(color: Theme.of(context).disabledColor.withOpacity(0.5), indent: 70, endIndent: 70, thickness: 1),
            const SizedBox(height: Dimensions.paddingSizeDefault),



            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              PackageWidget(title: '${'max_order'.tr} (${packages.maxOrder})', isSelect: canSelect ? true : false),

              PackageWidget(title: '${'max_product'.tr} (${packages.maxProduct})', isSelect: canSelect ? true : false),

              packages.pos == 1 ? PackageWidget(title: 'pos'.tr, isSelect: canSelect ? true : false) : const SizedBox(),

              packages.mobileApp == 1 ? PackageWidget(title: 'mobile_app'.tr, isSelect: canSelect ? true : false) : const SizedBox(),

              packages.chat == 1 ? PackageWidget(title: 'chat'.tr, isSelect: canSelect ? true : false) : const SizedBox(),

              packages.review == 1 ? PackageWidget(title: 'review'.tr, isSelect: canSelect ? true : false) : const SizedBox(),

              packages.selfDelivery == 1 ? PackageWidget(title: 'self_delivery'.tr, isSelect: canSelect ? true : false) : const SizedBox(),

            ]),
          ]),
        ),

      ]),
    );
  }
}
