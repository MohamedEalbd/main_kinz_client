import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/common/models/product_model.dart';
import 'package:stackfood_multivendor/common/widgets/build_button_widget.dart';
import 'package:stackfood_multivendor/common/widgets/cart_snackbar_widget.dart';
import 'package:stackfood_multivendor/features/food/domain/models/food_nearly_model.dart';
import 'package:stackfood_multivendor/features/splash/controllers/theme_controller.dart';
import 'package:stackfood_multivendor/util/images.dart';

import '../../../common/models/restaurant_model.dart';
import '../../../common/widgets/custom_favourite_widget.dart';
import '../../../common/widgets/custom_image_widget.dart';
import '../../../helper/responsive_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/domain/models/cart_model.dart';
import '../../favourite/controllers/favourite_controller.dart';
import '../../product/controllers/product_controller.dart';
import '../../restaurant/controllers/restaurant_controller.dart';
import '../controller/foods_nearly_controller.dart';
import '../domain/models/food_model.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodsModel? foodsModel;
  // final FoodsNearlyModel? foodNearly;

  const FoodDetailsScreen({super.key, this.foodsModel});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<FoodsNearlyController>().fetchFoodNearlyMe();
  }

  @override
  Widget build(BuildContext context) {
    Product? product;
    bool desktop = ResponsiveHelper.isDesktop(context);
    bool isRestaurant = true;
    final restaurant = Restaurant();
    double? discount;
    String? discountType;
    bool isAvailable;
    String? image;
    double price = 0;
    double discountPrice = 0;
    if (isRestaurant) {
      image = restaurant!.logoFullUrl;
      discount =
          restaurant!.discount != null ? restaurant!.discount!.discount : 0;
      discountType = restaurant!.discount != null
          ? restaurant!.discount!.discountType
          : 'percent';
      isAvailable = restaurant!.open == 1 && restaurant!.active!;
    }
    // else {
    //   // image = product!.imageFullUrl;
    //   // discount = (product!.restaurantDiscount == 0 || isCampaign) ? product!.discount : product!.restaurantDiscount;
    //   // discountType = (product!.restaurantDiscount == 0 || isCampaign) ? product!.discountType : 'percent';
    //   // isAvailable = DateConverter.isAvailable(product!.availableTimeStarts, product!.availableTimeEnds);
    //   // price = product!.price!;
    //   // discountPrice = PriceConverter.convertWithDiscount(price, discount, discountType)!;
    // }
    return Scaffold(
      //appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 1.1,
                      child: CustomImageWidget(
                        image: widget.foodsModel!.imageFullUrl ?? '',
                        width: double.infinity,
                        height: 400.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height:10.h),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.foodsModel!.name ?? '',
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing :5.w,
                        children: [
                          Text(
                            "${widget.foodsModel!.price}",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          GetBuilder<ThemeController>(
                              builder: (themeController) {
                                return SvgPicture.asset(Images.myMoney,height: 20.h,width:20.w,color:themeController.darkTheme? Colors.white: Colors.grey);
                              }
                          ),
                        ],
                      ),
                    ]),
                SizedBox(height: 5.h),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "(${"remaining".tr} ${widget.foodsModel!.itemStock})",
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7C0631)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Row(
                        spacing:5.w,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${widget.foodsModel!.discount}",
                            style: robotoRegular.copyWith(
                                fontSize: 12.sp,
                                color: Theme.of(context).hintColor,
                                decoration: TextDecoration.lineThrough,decorationColor: Color(0xff7C0631), decorationThickness: 2),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          GetBuilder<ThemeController>(
                              builder: (themeController) {
                                return SvgPicture.asset(Images.myMoney,height: 20.h,width:20.w,color:themeController.darkTheme? Colors.white: Colors.grey);
                              }
                          ),
                    ],
                      ),
                    ]),
                SizedBox(height: 5.h),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (widget.foodsModel!.ratingCount == 1)
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    // padding: const EdgeInsets.all(5),
                                    height: 20.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.30),
                                      borderRadius: BorderRadius.circular(4.r),
                                      //border: Border.all(color: Theme.of(context).cardColor, width: 2),
                                      // boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 0)],
                                    ),
                                    child: Row(
                                      children: [
                                        widget.foodsModel!.ratingCount == 1
                                            ? Text(
                                                '${widget.foodsModel!.avgRating?.toStringAsFixed(1)}',
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    fontSize: 20.sp))
                                            : const SizedBox(),
                                        SizedBox(
                                            width: widget.foodsModel!
                                                        .ratingCount ==
                                                    1
                                                ? 5
                                                : 0),
                                        widget.foodsModel!.ratingCount == 1
                                            ? Icon(Icons.star,
                                                color:
                                                    Theme.of(context).cardColor,
                                                size: 15)
                                            : const SizedBox(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                      Spacer(),

                      GetBuilder<CartController>(builder: (cartController) {
                        product = Product(
                          id: widget.foodsModel!.id,
                          name: widget.foodsModel!.name,
                          description: widget.foodsModel!.description,
                          imageFullUrl: widget.foodsModel!.imageFullUrl,
                          categoryId: widget.foodsModel!.categoryId,
                          // categoryIds: widget.foodsModel!.categoryIds as List<CategoryIds>? ,
                          //variations: widget.foodsModel!.variations as List<Variation>?,
                          //addOns: widget.foodsModel!.addOns as List<AddOns>?,
                          //choiceOptions: widget.foodsModel!.choiceOptions as List<ChoiceOptions>?,
                          price: widget.foodsModel!.price!.toDouble(),
                          tax: widget.foodsModel!.tax!.toDouble(),
                          discount: widget.foodsModel!.discount!.toDouble(),
                          discountType: widget.foodsModel!.discountType,
                          availableTimeStarts:
                              widget.foodsModel!.availableTimeStarts,
                          availableTimeEnds:
                              widget.foodsModel!.availableTimeEnds,
                          restaurantId: widget.foodsModel!.restaurantId,
                          restaurantName: widget.foodsModel!.restaurantName,
                          restaurantDiscount:
                              widget.foodsModel!.restaurantDiscount!.toDouble(),
                          restaurantStatus: widget.foodsModel!.restaurantStatus,
                          scheduleOrder: widget.foodsModel!.scheduleOrder,
                          avgRating: widget.foodsModel!.avgRating!.toDouble(),
                          ratingCount: widget.foodsModel!.ratingCount,
                          veg: widget.foodsModel!.veg,
                          cartQuantityLimit:
                              widget.foodsModel!.maximumCartQuantity,
                          isRestaurantHalalActive:
                              widget.foodsModel!.isHalal == 1,
                          isHalalFood: widget.foodsModel!.isHalal == 1,
                          stockType: widget.foodsModel!.stockType,
                          nutritionsName: widget.foodsModel!.nutritionsName,
                          //allergiesName: widget.foodsModel!.allergiesName as List<String>?,
                        );
                        int cartQty =
                            cartController.cartQuantity(widget.foodsModel!.id!);
                        int cartIndex = cartController.isExistInCart(
                            widget.foodsModel!.id, null);
                        CartModel cartModel = CartModel(
                          null,
                          price,
                          discountPrice,
                          (price - discountPrice),
                          1,
                          [],
                          [],
                          false,
                          product,
                          [],
                          widget.foodsModel!.maximumCartQuantity,
                          [],
                        );
                        return cartQty != 0
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusExtraLarge),
                                ),
                                child: Row(children: [
                                  InkWell(
                                    onTap: cartController.isLoading
                                        ? null
                                        : () {
                                            if (cartController
                                                    .cartList[cartIndex]
                                                    .quantity! >
                                                1) {
                                              cartController.setQuantity(
                                                  false, cartModel,
                                                  cartIndex: cartIndex);
                                            } else {
                                              cartController
                                                  .removeFromCart(cartIndex);
                                            }
                                          },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeExtraSmall),
                                      child: Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    child: Text(
                                      cartQty.toString(),
                                      style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Theme.of(context).cardColor),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: cartController.isLoading
                                        ? null
                                        : () {
                                            cartController.setQuantity(
                                                true, cartModel,
                                                cartIndex: cartIndex);
                                          },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeExtraSmall),
                                      child: Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ]),
                              )
                            : InkWell(
                                onTap: () => Get.find<ProductController>()
                                    .productDirectlyAddToCart(product, context),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(0, 1))
                                    ],
                                  ),
                                  child: Icon(Icons.add,
                                      size: 25,
                                      color: Theme.of(context).primaryColor),
                                ),
                              );
                      })
                      //: const SizedBox(),
                    ]),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.5),
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Prevents Row from expanding unnecessarily
                    children: [
                      Expanded( // Ensures content does not exceed screen width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Restaurant_and_branch".tr,
                              style: robotoMedium.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h), // Adds spacing between widgets
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: CustomImageWidget(
                                      image: widget.foodsModel!.restaurantImage ?? '',
                                      height: 35,
                                      width: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w), // Adds spacing between image and text
                                Expanded( // Prevents overflow in text columns
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.foodsModel!.restaurantName! ?? "",
                                        style: robotoMedium.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        spacing: 5.w,
                                        children: [
                                          Icon(Icons.location_on_outlined,size: 18,),
                                          Flexible(
                                            child: Text(
                                              widget.foodsModel!.restaurantAddress ?? '',
                                              style: robotoMedium.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w300,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "description".tr,
                    style: robotoRegular.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "${widget.foodsModel!.description}",
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).hintColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 40.h
                ),
                Row(
                  spacing: 5.w,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.find<ThemeController>().darkTheme
                            ? null
                            : Colors.white,
                      ),
                      child: GetBuilder<FavouriteController>(
                          builder: (favouriteController) {
                        bool isWished = favouriteController.wishProductIdList
                            .contains(product!.id);
                        //favouriteController.wishRestIdList.contains(widget.foodsModel!.restaurantId);
                        return CustomFavouriteWidget(
                          isWished: isWished,
                          isRestaurant: false,
                          restaurantId: widget.foodsModel!.restaurantId,
                          product: product,
                        );
                      }),
                    ),

                    // Expanded(
                    //   child: GetBuilder<CartController>(
                    //       builder: (cartController) {
                    //         return CustomButtonWidget(
                    //           radius : Dimensions.paddingSizeDefault,
                    //           width: ResponsiveHelper.isDesktop(context) ? MediaQuery.of(context).size.width / 2.0 : null,
                    //           isLoading: cartController.isLoading,
                    //           buttonText: (!product!.scheduleOrder! && !isAvailable) ? 'not_available_now'.tr
                    //               : widget.isCampaign ? 'order_now'.tr : (widget.cart != null || productController.cartIndex != -1) ? 'update_in_cart'.tr : 'add_to_cart'.tr,
                    //           onPressed: (!product!.scheduleOrder! && !isAvailable) || (widget.cart != null && productController.checkOutOfStockVariationSelected(product?.variations) != null) ? null : () async {
                    //
                    //             _onButtonPressed(productController, cartController, priceWithVariation, priceWithDiscount, price, discount, discountType, addOnIdList, addOnsList, priceWithAddonsVariation);
                    //
                    //           },
                    //         );
                    //       }
                    //   ),
                    // ),

                    Expanded(
                        child: BuildButtonWidget(
                      txt: "add_to_cart".tr,
                      onTap: () async {
                        // await Get.toNamed(RouteHelper.getCartRoute());
                        //  Get.find<RestaurantController>().makeEmptyRestaurant();
                        //  if(widget.foodsModel!.restaurantId != null) {
                        //    Get.find<RestaurantController>().getRestaurantDetails(Restaurant(id: widget.foodsModel!.restaurantId));
                        //  }
                        Get.find<ProductController>()
                            .productDirectlyAddToCart(product, context);
                        showCartSnackBarWidget();
                      },
                    )),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
// void _onButtonPressed(
//     ProductController productController, CartController cartController, double priceWithVariation, double priceWithDiscount,
//     double price, double? discount, String? discountType, List<AddOn> addOnIdList, List<AddOns> addOnsList,
//     double priceWithAddonsVariation,CartModel? cart,
//     ) async {
//
//   _processVariationWarning(productController);
//
//   if(productController.canAddToCartProduct) {
//     CartModel cartModel = CartModel(
//       null, priceWithVariation, priceWithDiscount, (price - PriceConverter.convertWithDiscount(price, discount, discountType)!),
//       productController.quantity, addOnIdList, addOnsList, widget.isCampaign, product, productController.selectedVariations,
//       product!.cartQuantityLimit, productController.variationsStock,
//     );
//
//     OnlineCart onlineCart = await _processOnlineCart(productController, cartController, addOnIdList, addOnsList, priceWithAddonsVariation);
//
//     debugPrint('-------checkout online cart body : ${onlineCart.toJson()}');
//     debugPrint('-------checkout cart : ${cartModel.toJson()}');
//
//     if(widget.isCampaign) {
//       Get.back();
//       Get.toNamed(RouteHelper.getCheckoutRoute('campaign'), arguments: CheckoutScreen(
//         fromCart: false, cartList: [cartModel],
//       ));
//     }else {
//       await _executeActions(cartController, productController, cartModel, onlineCart,cart);
//     }
//   }
// }
//
// void _processVariationWarning(ProductController productController) {
//   if(product!.variations != null && product!.variations!.isNotEmpty){
//     for(int index=0; index<product!.variations!.length; index++) {
//       if(!product!.variations![index].multiSelect! && product!.variations![index].required!
//           && !productController.selectedVariations[index].contains(true)) {
//         showCustomSnackBar('${'choose_a_variation_from'.tr} ${product!.variations![index].name}');
//         productController.changeCanAddToCartProduct(false);
//         return;
//       }else if(product!.variations![index].multiSelect! && (product!.variations![index].required!
//           || productController.selectedVariations[index].contains(true)) && product!.variations![index].min!
//           > productController.selectedVariationLength(productController.selectedVariations, index)) {
//         showCustomSnackBar('${'you_need_to_select_minimum'.tr} ${product!.variations![index].min} '
//             '${'to_maximum'.tr} ${product!.variations![index].max} ${'options_from'.tr} ${product!.variations![index].name} ${'variation'.tr}');
//         productController.changeCanAddToCartProduct(false);
//         return;
//       } else {
//         productController.changeCanAddToCartProduct(true);
//       }
//     }
//   } else if( !widget.isCampaign && product!.variations!.isEmpty && product!.stockType != 'unlimited' && product!.itemStock! <= 0) {
//     showCustomSnackBar('product_is_out_of_stock'.tr);
//     productController.changeCanAddToCartProduct(false);
//     return;
//   }
// }
//
// Future<OnlineCart> _processOnlineCart(ProductController productController, CartController cartController, List<AddOn> addOnIdList, List<AddOns> addOnsList, double priceWithAddonsVariation) async {
//   List<OrderVariation> variations = CartHelper.getSelectedVariations(
//     productVariations: product!.variations, selectedVariations: productController.selectedVariations,
//   ).$1;
//   List<int?> optionsIdList = CartHelper.getSelectedVariations(
//     productVariations: product!.variations, selectedVariations: productController.selectedVariations,
//   ).$2;
//   List<int?> listOfAddOnId = CartHelper.getSelectedAddonIds(addOnIdList: addOnIdList);
//   List<int?> listOfAddOnQty = CartHelper.getSelectedAddonQtnList(addOnIdList: addOnIdList);
//
//   OnlineCart onlineCart = OnlineCart(
//       (widget.cart != null || productController.cartIndex != -1) ? widget.cart?.id ?? cartController.cartList[productController.cartIndex].id : null,
//       widget.isCampaign ? null : product!.id, widget.isCampaign ? product!.id : null,
//       priceWithAddonsVariation.toString(), variations,
//       productController.quantity, listOfAddOnId, addOnsList, listOfAddOnQty, 'Food', variationOptionIds: optionsIdList
//   );
//   return onlineCart;
// }
//
// Future<void> _executeActions(CartController cartController, ProductController productController, CartModel cartModel, OnlineCart onlineCart,CartModel? cart) async {
//   if (cartController.existAnotherRestaurantProduct(cartModel.product!.restaurantId)) {
//     Get.dialog(ConfirmationDialogWidget(
//       icon: Images.warning,
//       title: 'are_you_sure_to_reset'.tr,
//       description: 'if_you_continue'.tr,
//       onYesPressed: () {
//         Get.back();
//         cartController.clearCartOnline().then((success) async {
//           if(success) {
//             await cartController.addToCartOnline(onlineCart, existCartData: cart);
//           }
//         });
//
//       },
//     ), barrierDismissible: false);
//   } else {
//     if(cart != null || productController.cartIndex != -1) {
//       await cartController.updateCartOnline(onlineCart, existCartData:cart);
//     } else {
//       await cartController.addToCartOnline(onlineCart, existCartData: cart);
//     }
//   }
// }
}
