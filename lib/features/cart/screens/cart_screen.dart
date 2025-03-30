import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:stackfood_multivendor/common/widgets/custom_ink_well_widget.dart';
import 'package:stackfood_multivendor/common/widgets/custom_snackbar_widget.dart';
import 'package:stackfood_multivendor/features/cart/controllers/cart_controller.dart';
import 'package:stackfood_multivendor/features/cart/widgets/cart_product_widget.dart';
import 'package:stackfood_multivendor/features/cart/widgets/cart_suggested_item_view_widget.dart';
import 'package:stackfood_multivendor/features/cart/widgets/checkout_button_widget.dart';
import 'package:stackfood_multivendor/features/cart/widgets/pricing_view_widget.dart';
import 'package:stackfood_multivendor/features/checkout/controllers/checkout_controller.dart';
import 'package:stackfood_multivendor/features/profile/controllers/profile_controller.dart';
import 'package:stackfood_multivendor/features/restaurant/controllers/restaurant_controller.dart';
import 'package:stackfood_multivendor/common/models/restaurant_model.dart';
import 'package:stackfood_multivendor/helper/date_converter.dart';
import 'package:stackfood_multivendor/helper/price_converter.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/styles.dart';
import 'package:stackfood_multivendor/common/widgets/custom_app_bar_widget.dart';
import 'package:stackfood_multivendor/common/widgets/footer_view_widget.dart';
import 'package:stackfood_multivendor/common/widgets/menu_drawer_widget.dart';
import 'package:stackfood_multivendor/common/widgets/no_data_screen_widget.dart';
import 'package:stackfood_multivendor/common/widgets/web_constrained_box.dart';
import 'package:stackfood_multivendor/common/widgets/web_page_title_widget.dart';
import 'package:stackfood_multivendor/features/restaurant/screens/restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  final bool fromNav;
  final bool fromReorder;
  const CartScreen(
      {super.key, required this.fromNav, this.fromReorder = false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController scrollController = ScrollController();
  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();

  final GlobalKey _widgetKey = GlobalKey();
  double _height = 0;

  @override
  void initState() {
    super.initState();

    //initCall();
  }

  Future<void> initCall() async {
    _initialBottomSheetShowHide();
    Get.find<RestaurantController>().makeEmptyRestaurant(willUpdate: false);
    Get.find<CartController>().setAvailableIndex(-1, willUpdate: false);
    Get.find<CheckoutController>().setInstruction(-1, willUpdate: false);
    await Get.find<CartController>().getCartDataOnline();
    if (Get.find<CartController>().cartList.isNotEmpty) {
      await Get.find<RestaurantController>().getRestaurantDetails(
          Restaurant(
              id: Get.find<CartController>().cartList[0].product!.restaurantId,
              name: null),
          fromCart: true);
      Get.find<CartController>().calculationCart();
      if (Get.find<CartController>().addCutlery) {
        Get.find<CartController>().updateCutlery(isUpdate: false);
      }
      if (Get.find<CartController>().needExtraPackage) {
        Get.find<CartController>().toggleExtraPackage(willUpdate: false);
      }
      Get.find<RestaurantController>().getCartRestaurantSuggestedItemList(
          Get.find<CartController>().cartList[0].product!.restaurantId);
      showReferAndEarnSnackBar();
    }
  }

  void _initialBottomSheetShowHide() {
    Future.delayed(const Duration(milliseconds: 600), () {
      key.currentState!.expand();
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          key.currentState!.contract();
        });
      });
    });
  }

  void _getExpandedBottomSheetHeight() {
    // Use the key to get the context and the size of the widget
    final RenderBox renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;

    setState(() {
      _height = size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);

    // Get.put(MyCartController());
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       onPressed: () {
    //         Get.back();
    //       },
    //       icon: Image.asset(Images.arrowLeft1),
    //     ),
    //     title: Text(
    //       "My Cart".tr,
    //       style: TextStyle(
    //         fontFamily: "Inter",
    //         fontSize: 14.sp,
    //         height: (14 / 16.94).sp,
    //         fontWeight: FontWeight.w600,
    //         color: Color(0xff1E1E1E),
    //       ),
    //     ),
    //     centerTitle: true,
    //   ),
    //   body: GetBuilder<MyCartController>(
    //     builder: (controller) => Column(
    //       children: [
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height * 0.45,
    //           child: ListView.builder(
    //               padding: EdgeInsets.symmetric(horizontal: 16.w),
    //               shrinkWrap: true,
    //               itemCount: controller.foods.length,
    //               itemBuilder: (_, index) {
    //                 return Container(
    //                   alignment: Alignment.center,
    //                   child: Card(
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Padding(
    //                           padding: EdgeInsets.only(left: 8.w),
    //                           child: ClipRRect(
    //                             borderRadius: BorderRadius.circular(6.r),
    //                             child: Image.asset(
    //                                 controller.foods[index].imageUrl),
    //                           ),
    //                         ),
    //                         SizedBox(width: 8.w),
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             Row(
    //                               spacing: 16.w,
    //                               mainAxisSize: MainAxisSize.min,
    //                               children: [
    //                                 Text(
    //                                   "${controller.foods[index].name}",
    //                                   style: TextStyle(
    //                                     fontFamily: "Inter",
    //                                     fontSize: 12.sp,
    //                                     fontWeight: FontWeight.w600,
    //                                     color: Color(0xff1E1E1E),
    //                                   ),
    //                                 ),
    //                                 Container(
    //                                   height: 20.h,
    //                                   width: 70.w,
    //                                   alignment: Alignment.center,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius:
    //                                         BorderRadius.circular(6.r),
    //                                     color:
    //                                         Color(0xff7C0631).withOpacity(0.15),
    //                                   ),
    //                                   child: Text(
    //                                     "Received",
    //                                     style: TextStyle(
    //                                       fontFamily: "Inter",
    //                                       fontWeight: FontWeight.w500,
    //                                       fontSize: 10.sp,
    //                                       height: (10 / 12.1).sp,
    //                                       color: Color(0xff7C0631),
    //                                     ),
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                             SizedBox(height: 8.h),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Row(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   children: [
    //                                     ...List.generate(5, (index) {
    //                                       return Icon(
    //                                         Icons.star,
    //                                         size: 10,
    //                                         color: Color(0xffFCE340),
    //                                       );
    //                                     }),
    //                                   ],
    //                                 ),
    //                                 SizedBox(width: 6.w),
    //                                 Text(
    //                                   "${controller.foods[index].rate}",
    //                                   style: TextStyle(
    //                                       fontSize: 10.sp,
    //                                       fontFamily: "Inter",
    //                                       fontWeight: FontWeight.w400,
    //                                       color: Color(0xff1E1E1E)),
    //                                 ),
    //                               ],
    //                             ),
    //                             SizedBox(height: 6.5.h),
    //                             Text(
    //                               "${controller.foods[index].price} SAR",
    //                               style: TextStyle(
    //                                 fontSize: 12.sp,
    //                                 fontWeight: FontWeight.w600,
    //                                 fontFamily: "Inter",
    //                                 color: Color(0xff1E1E1E),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         Spacer(),
    //                         Padding(
    //                           padding: EdgeInsets.symmetric(horizontal: 8.w),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             spacing: 8.w,
    //                             children: [
    //                               IconButton(
    //                                 onPressed: () {},
    //                                 icon: Icon(Icons.remove),
    //                               ),
    //                               Text(
    //                                 "1",
    //                                 style: TextStyle(
    //                                   fontFamily: "Inter",
    //                                   fontSize: 16.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   height: (16 / 19.36).sp,
    //                                   color: Colors.black,
    //                                 ),
    //                               ),
    //                               GestureDetector(
    //                                 onTap: () {},
    //                                 child: Container(
    //                                   height: 25.h,
    //                                   width: 25.w,
    //                                   alignment: Alignment.center,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius:
    //                                         BorderRadius.circular(100.r),
    //                                     color: Color(0xff7C0631),
    //                                   ),
    //                                   child: Icon(
    //                                     Icons.add,
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               }),
    //         ),
    //         SizedBox(height: 16.h),
    //         Container(
    //           height: 60.h,
    //           width: double.infinity,
    //           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    //           margin: EdgeInsets.symmetric(horizontal: 16.w),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(10.r),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.shade300,
    //                 blurRadius: 5.0,
    //                 spreadRadius: 2.0,
    //                 offset: Offset(0, 0),
    //               ),
    //             ],
    //           ),
    //           child: Column(
    //             spacing: 4.h,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 "Pick Up Time".tr,
    //                 style: TextStyle(
    //                   fontSize: 12.sp,
    //                   fontWeight: FontWeight.w600,
    //                   fontFamily: "Inter",
    //                   color: Color(0xff1E1E1E),
    //                 ),
    //               ),
    //               Text(
    //                 "Today: 12:00 PM - 04.00 AM".tr,
    //                 style: TextStyle(
    //                   fontSize: 12.sp,
    //                   fontWeight: FontWeight.w600,
    //                   fontFamily: "Inter",
    //                   color: Color(0xff7C0631),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 10.w),
    //           child: Row(
    //             spacing: 8.w,
    //             children: [
    //               IconButton(
    //                 onPressed: () {
    //                   showModalBottomSheet(
    //                       context: context,
    //                       builder: (context) {
    //                         return Container(
    //                           padding: EdgeInsets.symmetric(
    //                             horizontal: 16.w,
    //                             vertical: 10.h,
    //                           ),
    //                           height: 352.h,
    //                           width: double.infinity,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.only(
    //                               topRight: Radius.circular(31.r),
    //                               topLeft: Radius.circular(31.r),
    //                             ),
    //                           ),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Align(
    //                                 alignment: Alignment.topRight,
    //                                 child: Container(
    //                                   height: 33.h,
    //                                   width: 33.w,
    //                                   decoration: BoxDecoration(
    //                                     borderRadius:
    //                                         BorderRadius.circular(100.r),
    //                                     color: Color(0xFF7D7D7D),
    //                                   ),
    //                                   child: InkWell(
    //                                     onTap: () {
    //                                       Get.back();
    //                                     },
    //                                     child: Container(
    //                                       alignment: Alignment.center,
    //                                       child: Icon(
    //                                         Icons.close,
    //                                         color: Colors.white,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                               Text(
    //                                 "Confirm The Order".tr,
    //                                 style: TextStyle(
    //                                   fontSize: 16.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   fontFamily: "Inter",
    //                                   height: (16 / 19.36).sp,
    //                                   color: Color(0xff1E1E1E),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 12.h),
    //                               Text(
    //                                 "Please confirm the order details before proceeding with payment"
    //                                     .tr,
    //                                 style: TextStyle(
    //                                   fontSize: 10.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   fontFamily: "Inter",
    //                                   height: (10 / 12.1).sp,
    //                                   color: Color(0xff7D7D7D),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 12.h),
    //                               Divider(
    //                                 color: Color(0xff7D7D7D),
    //                               ),
    //                               SizedBox(height: 32.h),
    //                               Text(
    //                                 "Request type".tr,
    //                                 style: TextStyle(
    //                                   fontSize: 10.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   fontFamily: "Inter",
    //                                   height: (10 / 12.1).sp,
    //                                   color: Color(0xff7D7D7D),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 8.h),
    //                               Text(
    //                                 "Receipt from the branch".tr,
    //                                 style: TextStyle(
    //                                   fontSize: 10.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   fontFamily: "Inter",
    //                                   height: (10 / 12.1).sp,
    //                                   color: Color(0xff1E1E1E),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 24.h),
    //                               Text(
    //                                 "Date of receipt".tr,
    //                                 style: TextStyle(
    //                                   fontSize: 10.sp,
    //                                   fontWeight: FontWeight.w600,
    //                                   fontFamily: "Inter",
    //                                   height: (10 / 12.1).sp,
    //                                   color: Color(0xff7D7D7D),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 8.h),
    //                               Text(
    //                                 "today, 25/5/2024".tr,
    //                                 style: TextStyle(
    //                                   fontSize: 8.sp,
    //                                   fontWeight: FontWeight.w600,
    //                                   fontFamily: "Inter",
    //                                   height: (8 / 9.68).sp,
    //                                   color: Color(0xff7C0631),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 24.h),
    //                               Text(
    //                                 "Pick up time".tr,
    //                                 style: TextStyle(
    //                                   fontSize: 10.sp,
    //                                   fontWeight: FontWeight.w600,
    //                                   fontFamily: "Inter",
    //                                   height: (10 / 12.1).sp,
    //                                   color: Color(0xff7D7D7D),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 8.h),
    //                               Text(
    //                                 "today, 12:00pm - 4:00am".tr,
    //                                 style: TextStyle(
    //                                   fontSize: 8.sp,
    //                                   fontWeight: FontWeight.w600,
    //                                   fontFamily: "Inter",
    //                                   height: (8 / 9.68).sp,
    //                                   color: Color(0xff1E1E1E),
    //                                 ),
    //                               ),
    //                               SizedBox(height: 22.h),
    //                               SizedBox(
    //                                 height: 35.h,
    //                                 child: BuildButtonWidget(
    //                                   onTap: () {
    //                                     Get.to(
    //                                       () => CheckoutScreen(
    //                                         fromCart: false,
    //                                         cartList: [],
    //                                       ),
    //                                     );
    //                                   },
    //                                   txt: "Confirm Order",
    //                                   textStyle: TextStyle(
    //                                     fontSize: 14.sp,
    //                                     fontWeight: FontWeight.w500,
    //                                     fontFamily: "Inter",
    //                                     height: (14 / 16.94).sp,
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         );
    //                       });
    //                 },
    //                 icon: Icon(
    //                   Icons.add_circle_outline_rounded,
    //                   color: Color(0xff7C0631),
    //                 ),
    //               ),
    //               Text(
    //                 "Add more items".tr,
    //                 style: TextStyle(
    //                   fontSize: 12.sp,
    //                   fontWeight: FontWeight.w600,
    //                   fontFamily: "Inter",
    //                   color: Color(0xff7C0631),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'my_cart'.tr, isBackButtonExist: (isDesktop || !widget.fromNav)),
      endDrawer: const MenuDrawerWidget(), endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<RestaurantController>(builder: (restaurantController) {
        return GetBuilder<CartController>(builder: (cartController) {

          bool isRestaurantOpen = true;

          if(restaurantController.restaurant != null) {
            isRestaurantOpen = restaurantController.isRestaurantOpenNow(restaurantController.restaurant!.active!, restaurantController.restaurant!.schedules);
          }

          bool suggestionEmpty = (restaurantController.suggestedItems != null && restaurantController.suggestedItems!.isEmpty);
          return (cartController.isLoading && widget.fromReorder) ? const Center(
            child: SizedBox(height: 30, width: 30, child: CircularProgressIndicator()),
          ) : cartController.cartList.isNotEmpty ? Column(
            children: [
              Expanded(
                child: ExpandableBottomSheet(
                  key: key,
                  persistentHeader: isDesktop ? const SizedBox() : InkWell(
                    onTap: (){
                      if(cartController.isExpanded){
                        cartController.setExpanded(false);
                        setState(() {
                          key.currentState!.contract();
                        });

                      } else {
                        cartController.setExpanded(true);
                        setState(() {
                          key.currentState!.expand();
                        });
                      }
                    },
                    child: Container(
                      color: Theme.of(context).cardColor,
                      child: Container(
                        constraints: const BoxConstraints.expand(height: 30),
                        decoration: BoxDecoration(
                          color: Theme.of(context).disabledColor.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault)),
                        ),
                        child: Icon(Icons.drag_handle, color: Theme.of(context).hintColor, size: 25),
                      ),
                    ),
                  ),
                  background: Column(
                    children: [
                      WebScreenTitleWidget(title: 'my_cart'.tr),

                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: isDesktop ? const EdgeInsets.only(top: Dimensions.paddingSizeSmall) : EdgeInsets.zero,
                          child: FooterViewWidget(
                            child: Center(
                              child: SizedBox(
                                width: Dimensions.webMaxWidth,
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Expanded(
                                      flex: 6,
                                      child: Column(children: [
                                        Container(
                                          decoration: isDesktop ? BoxDecoration(
                                            borderRadius: const  BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                                            color: Theme.of(context).cardColor,
                                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 10, offset: const Offset(0, 1))],
                                          ) : const BoxDecoration(),
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            WebConstrainedBox(
                                              dataLength: cartController.cartList.length, minLength: 5, minHeight: suggestionEmpty ? 0.6 : 0.3,
                                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                                !isRestaurantOpen && restaurantController.restaurant != null ? !isDesktop ? Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                                    child: RichText(
                                                      textAlign: TextAlign.center,
                                                      text: TextSpan(children: [
                                                        TextSpan(text: 'currently_the_restaurant_is_unavailable_the_restaurant_will_be_available_at'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
                                                        const TextSpan(text: ' '),
                                                        TextSpan(
                                                          text: restaurantController.restaurant!.restaurantOpeningTime == 'closed' ? 'tomorrow'.tr : DateConverter.timeStringToTime(restaurantController.restaurant!.restaurantOpeningTime!),
                                                          style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ) : Container(

                                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                    borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault),
                                                    ),
                                                  ),
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                                                    RichText(
                                                      textAlign: TextAlign.start,
                                                      text: TextSpan(children: [
                                                        TextSpan(text: 'currently_the_restaurant_is_unavailable_the_restaurant_will_be_available_at'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
                                                        const TextSpan(text: ' '),
                                                        TextSpan(
                                                          text: restaurantController.restaurant!.restaurantOpeningTime == 'closed' ? 'tomorrow'.tr : DateConverter.timeStringToTime(restaurantController.restaurant!.restaurantOpeningTime!),
                                                          style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),
                                                        ),
                                                      ]),
                                                    ),

                                                    !isRestaurantOpen ? Align(
                                                      alignment: Alignment.center,
                                                      child: InkWell(
                                                        onTap: () {
                                                          cartController.clearCartOnline();
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                                          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context).cardColor,
                                                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                                            border: Border.all(width: 1, color: Theme.of(context).disabledColor.withOpacity(0.3)),
                                                          ),
                                                          child: !cartController.isClearCartLoading ? Row(mainAxisSize: MainAxisSize.min, children: [

                                                            Icon(CupertinoIcons.delete_solid, color: Theme.of(context).colorScheme.error, size: 20),
                                                            const SizedBox(width: Dimensions.paddingSizeSmall),

                                                            Text(
                                                              cartController.cartList.length > 1 ? 'remove_all_from_cart'.tr : 'remove_from_cart'.tr,
                                                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.7)),
                                                            ),

                                                          ]) : const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                                                        ),
                                                      ),
                                                    ) : const SizedBox(),

                                                  ]),

                                                ) : const SizedBox(),

                                                ConstrainedBox(
                                                  constraints: BoxConstraints(maxHeight: isDesktop ? MediaQuery.of(context).size.height * 0.4 : double.infinity),
                                                  child: ListView.builder(
                                                    physics: isDesktop ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: const EdgeInsets.only(
                                                      left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault,
                                                    ),
                                                    itemCount: cartController.cartList.length,
                                                    itemBuilder: (context, index) {
                                                      return CartProductWidget(
                                                        cart: cartController.cartList[index], cartIndex: index, addOns: cartController.addOnsList[index],
                                                        isAvailable: cartController.availableList[index], isRestaurantOpen: isRestaurantOpen,
                                                      );
                                                    },
                                                  ),
                                                ),

                                                !isRestaurantOpen ? !isDesktop ? Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                                    child: CustomInkWellWidget(
                                                      onTap: () {
                                                        cartController.clearCartOnline();
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                                        decoration: BoxDecoration(
                                                          color: Theme.of(context).cardColor,
                                                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                                          border: Border.all(width: 1, color: Theme.of(context).disabledColor.withOpacity(0.3)),
                                                        ),
                                                        child: !cartController.isClearCartLoading ? Row(mainAxisSize: MainAxisSize.min, children: [

                                                          Icon(CupertinoIcons.delete_solid, color: Theme.of(context).colorScheme.error, size: 20),
                                                          const SizedBox(width: Dimensions.paddingSizeSmall),

                                                          Text(cartController.cartList.length > 1 ? 'remove_all_from_cart'.tr : 'remove_from_cart'.tr, style: robotoMedium.copyWith(color: Theme.of(context).colorScheme.error, fontSize: Dimensions.fontSizeSmall)),

                                                        ]) : const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                                                      ),
                                                    ),
                                                  ),
                                                ) : const SizedBox() : const SizedBox(),

                                                // !isDesktop ? const SizedBox(height: Dimensions.paddingSizeLarge): const SizedBox(),

                                                // !isDesktop ? Container(height: 1, color: Theme.of(context).disabledColor.withOpacity(0.3)) : const SizedBox(),

                                                SizedBox(height: isDesktop ? 40 : 0),

                                                Container(
                                                  alignment: Alignment.center,
                                                  color: Theme.of(context).cardColor.withOpacity(0.6),
                                                  child: TextButton.icon(
                                                    onPressed: (){
                                                      if(isRestaurantOpen) {
                                                        Get.toNamed(
                                                          RouteHelper.getRestaurantRoute(cartController.cartList[0].product!.restaurantId),
                                                          arguments: RestaurantScreen(restaurant: Restaurant(id: cartController.cartList[0].product!.restaurantId)),
                                                        );
                                                      } else {
                                                        Get.offAllNamed(RouteHelper.getInitialRoute(fromSplash: true));
                                                      }
                                                    },
                                                    icon: Icon(Icons.add_circle_outline_sharp, color: Theme.of(context).primaryColor),
                                                    label: Text(
                                                      isRestaurantOpen ? 'add_more_items'.tr : 'add_from_another_restaurants'.tr,
                                                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: !isDesktop ? 0 : 8),

                                                !isDesktop ? CartSuggestedItemViewWidget(cartList: cartController.cartList) : const SizedBox(),
                                              ]),
                                            ),
                                            const SizedBox(height: Dimensions.paddingSizeSmall),

                                            !isDesktop ? PricingViewWidget(cartController: cartController, isRestaurantOpen: isRestaurantOpen,) : const SizedBox(),
                                          ]),
                                        ),
                                        const SizedBox(height: Dimensions.paddingSizeSmall),

                                        isDesktop ? CartSuggestedItemViewWidget(cartList: cartController.cartList) : const SizedBox(),
                                      ]),
                                    ),
                                    SizedBox(width: isDesktop ? Dimensions.paddingSizeLarge : 0),

                                    isDesktop ? Expanded(flex: 4, child: PricingViewWidget(cartController: cartController, isRestaurantOpen: isRestaurantOpen,)) : const SizedBox(),

                                  ]),

                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: _height),

                    ],
                  ),

                  onIsExtendedCallback: () {
                    ///Don't remove this print.
                    print('======= expandableContent open');
                    _getExpandedBottomSheetHeight();
                  },
                  onIsContractedCallback: () {
                    ///Don't remove this print.
                    print('======= expandableContent close');
                    setState(() {
                      _height = 0;
                    });
                  },

                  expandableContent: isDesktop ? const SizedBox() : Container(
                    width: context.width,
                    key: _widgetKey,  // Assign the GlobalKey to the widget
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault)),
                    ),
                    child: Column(children: [

                      Container(
                        padding: const EdgeInsets.only(
                          left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeSmall,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault)),
                        ),
                        child: Column(children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('item_price'.tr, style: robotoRegular),
                            PriceConverter.convertAnimationPrice(cartController.itemPrice, textStyle: robotoRegular),
                          ]),
                          SizedBox(height: cartController.variationPrice > 0 ? Dimensions.paddingSizeSmall : 0),

                          cartController.variationPrice > 0 ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('variations'.tr, style: robotoRegular),
                              Text('(+) ${PriceConverter.convertPrice(cartController.variationPrice)}', style: robotoRegular, textDirection: TextDirection.ltr),
                            ],
                          ) : const SizedBox(),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('discount'.tr, style: robotoRegular),
                            restaurantController.restaurant != null ? Row(children: [
                              Text('(-)', style: robotoRegular),
                              PriceConverter.convertAnimationPrice(cartController.itemDiscountPrice, textStyle: robotoRegular),
                            ]) : Text('calculating'.tr, style: robotoRegular),
                          ]),
                          const SizedBox(height: Dimensions.paddingSizeSmall),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('addons'.tr, style: robotoRegular),
                              Row(children: [
                                Text('(+)', style: robotoRegular),
                                PriceConverter.convertAnimationPrice(cartController.addOns, textStyle: robotoRegular),
                              ]),
                            ],
                          ),

                        ]),
                      ),

                    ]),
                  ),

                ),
              ),

              isDesktop ? const SizedBox.shrink() : CheckoutButtonWidget(cartController: cartController, availableList: cartController.availableList, isRestaurantOpen: isRestaurantOpen),

            ],
          ) : SingleChildScrollView(child: FooterViewWidget(child: NoDataScreen(isEmptyCart: true, title: 'you_have_not_add_to_cart_yet'.tr)));
        },
        );
      }),
    );
  }

  Future<void> showReferAndEarnSnackBar() async {
    String text = 'your_referral_discount_added_on_your_first_order'.tr;
    if (Get.find<ProfileController>().userInfoModel != null &&
        Get.find<ProfileController>().userInfoModel!.isValidForDiscount!) {
      showCustomSnackBar(text, isError: false);
    }
  }
}
