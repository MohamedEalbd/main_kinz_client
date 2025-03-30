
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stackfood_multivendor/features/home/controllers/suggest_products_controller.dart';
import 'package:stackfood_multivendor/features/home/widgets/theme1/custom_container_distplay_foods.dart';
import 'package:stackfood_multivendor/features/restaurant/screens/restaurant_screen.dart';
import 'package:stackfood_multivendor/helper/responsive_helper.dart';
import 'package:stackfood_multivendor/util/color_resources.dart';
import 'package:video_player/video_player.dart';

import '../../../common/models/product_model.dart';
import '../../../common/models/restaurant_model.dart';
import '../../../common/widgets/custom_asset_image_widget.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../language/controllers/localization_controller.dart';
import '../../food/controller/foods_nearly_controller.dart';
import '../controllers/advertisement_controller.dart';
import '../domain/models/advertisement_model.dart';

class DisplayProductForNearByMe extends StatefulWidget {
  const DisplayProductForNearByMe({super.key});

  @override
  State<DisplayProductForNearByMe> createState() => _DisplayProductForNearByMeState();
}

class _DisplayProductForNearByMeState extends State<DisplayProductForNearByMe> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<FoodsNearlyController>().fetchFoodNearlyMe();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodsNearlyController>(builder: (foodsNearlyController) {
      return  foodsNearlyController.myFood.isNotEmpty ? Padding(
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeDefault),
        child: Stack(
          children: [

            CustomAssetImageWidget(
              Images.highlightBg, width: context.width,
              fit: BoxFit.cover,
            ),

            Column(children: [

              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeExtraSmall,
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('highlights_for_you'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black)),
                      const SizedBox(width: 5),

                      Text('see_our_most_popular_restaurant_and_foods'.tr, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall)),
                    ],
                  ),

                  const CustomAssetImageWidget(
                    Images.highlightIcon, height: 50, width: 50,
                  ),

                ]),
              ),
              CarouselSlider(options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: false,
                height: 280,
                viewportFraction: 1,
                disableCenter: true,
              ), items: foodsNearlyController.myFood.map((food){
          return Builder(builder: (context){
          return   HighlightFoodsWidget(food:food );

          });
              }).toList(),),
              // CarouselSlider.builder(
              //   carouselController: _carouselController,
              //   itemCount:
              //   //searchController.allProductList!.length,
              //   suggestProductsController.suggestedFoodList!.length,
              //   options: CarouselOptions(
              //     enableInfiniteScroll: suggestProductsController.suggestedFoodList!.length > 2,
              //     autoPlay: true,//advertisementController.autoPlay,
              //     enlargeCenterPage: false,
              //     height: 280,
              //     viewportFraction: 1,
              //     disableCenter: true,
              //     // onPageChanged: (index, reason) {
              //     //
              //     //   advertisementController.setCurrentIndex(index, true);
              //     //
              //     //   if(advertisementController.suggestedFoodList?[index]==0){//.addType == "video_promotion"
              //     //     advertisementController.updateAutoPlayStatus(status: false);
              //     //   }else{
              //     //     advertisementController.updateAutoPlayStatus(status: true);
              //     //   }
              //     //
              //     // },
              //   ),
              //
              //   itemBuilder: (context, index, realIndex) {
              //     return
              //       HighlightRestaurantWidget(product: suggestProductsController.suggestedFoodList![index]);
              //       // advertisementController.advertisementList?[index].addType == 'video_promotion' ? HighlightVideoWidget(
              //       //   advertisement: advertisementController.advertisementList![index],
              //       // ) : HighlightRestaurantWidget(advertisement: advertisementController.advertisementList![index]);
              //   },
              // ),

              const AdvertisementIndicator(),

              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

            ]),
          ],
        ),
      ) : foodsNearlyController.myFood.isNotEmpty ? const AdvertisementShimmer() : const SizedBox();

    });
  }
}

class HighlightVideoWidget extends StatefulWidget {
  final AdvertisementModel advertisement;
  const HighlightVideoWidget({super.key, required this.advertisement});

  @override
  State<HighlightVideoWidget> createState() => _HighlightVideoWidgetState();
}

class _HighlightVideoWidgetState extends State<HighlightVideoWidget> {

  late VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();

    videoPlayerController.addListener(() {
      if(videoPlayerController.value.duration == videoPlayerController.value.position){
        if(GetPlatform.isWeb){
          Future.delayed(const Duration(seconds: 4), () {
            Get.find<AdvertisementController>().updateAutoPlayStatus(status: true, shouldUpdate: true);
          });
        }else{
          Get.find<AdvertisementController>().updateAutoPlayStatus(status: true, shouldUpdate: true);
        }
      }
    });
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
      widget.advertisement.videoAttachmentFullUrl ?? "",
    ));

    await Future.wait([
      videoPlayerController.initialize(),
    ]);

    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      aspectRatio: videoPlayerController.value.aspectRatio,
    );
    _chewieController?.setVolume(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvertisementController>(builder: (advertisementController) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).disabledColor.withOpacity(0.07), width: 2),
        ),
        child: Column(children: [

          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusDefault)),
              child: Stack(
                children: [
                  _chewieController != null &&  _chewieController!.videoPlayerController.value.isInitialized ? Stack(
                    children: [
                      Chewie(controller: _chewieController!),
                    ],
                  ) : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Text(
                  widget.advertisement.title ?? '',
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600),
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Expanded(
                    child: Text(
                      widget.advertisement.description ?? '',
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                      maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  InkWell(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRestaurantRoute(widget.advertisement.restaurantId),
                        arguments: RestaurantScreen(restaurant: Restaurant(id: widget.advertisement.restaurantId)),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                      child: Icon(Icons.arrow_forward, color: Theme.of(context).cardColor, size: 20),
                    ),
                  ),

                ]),

              ]),
            ),
          ),

        ]),
      );
    });
  }
}

class AdvertisementIndicator extends StatelessWidget {
  const AdvertisementIndicator({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SuggestProductsController>(builder: (suggestProductsController) {
      return suggestProductsController.suggestedFoodList != null && suggestProductsController.suggestedFoodList!.length > 2 ?
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(height: 7, width: 7,
          decoration:  BoxDecoration(color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: suggestProductsController.suggestedFoodList!.map((advertisement) {
            int index = suggestProductsController.suggestedFoodList!.indexOf(advertisement);
            return index == suggestProductsController.currentIndex ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              decoration: BoxDecoration(
                  color:  Theme.of(context).primaryColor ,
                  borderRadius: BorderRadius.circular(50)),
              child:  Text("${index+1}/ ${suggestProductsController.suggestedFoodList!.length}",
                style: const TextStyle(color: Colors.white,fontSize: 12),),
            ):const SizedBox();
          }).toList(),
        ),
        Container(
          height: 7, width: 7,
          decoration:  BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ]): suggestProductsController.suggestedFoodList != null && suggestProductsController.suggestedFoodList!.length == 2 ?
      Align(
        alignment: Alignment.center,
        child: AnimatedSmoothIndicator(
          activeIndex: suggestProductsController.currentIndex,
          count: suggestProductsController.suggestedFoodList!.length,
          effect: ExpandingDotsEffect(
            dotHeight: 7,
            dotWidth: 7,
            spacing: 5,
            activeDotColor: Theme.of(context).colorScheme.primary,
            dotColor: Theme.of(context).hintColor.withOpacity(0.6),
          ),
        ),
      ): const SizedBox();
    });
  }
}

class AdvertisementShimmer extends StatelessWidget {
  const AdvertisementShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
        ),
        margin:  EdgeInsets.only(
          top: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge * 3.5 : 0 ,
          right: Get.find<LocalizationController>().isLtr && ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : 0,
          left: !Get.find<LocalizationController>().isLtr && ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : 0,
        ),
        child: Padding( padding : const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: Dimensions.paddingSizeLarge,),

              Container(height: 20, width: 200,
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).shadowColor
                ),),

              const SizedBox(height: Dimensions.paddingSizeSmall,),

              Container(height: 15, width: 250,
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).shadowColor,
                ),),

              const SizedBox(height: Dimensions.paddingSizeDefault * 2,),

              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: ResponsiveHelper.isDesktop(context) ? 3 : 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: ResponsiveHelper.isDesktop(context) ? (Dimensions.webMaxWidth - 20) / 3 : MediaQuery.of(context).size.width,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Padding(padding: const EdgeInsets.only(bottom: 0, left: 10, right: 10),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                color: Theme.of(context).shadowColor,
                                border: Border.all(color: Theme.of(context).hintColor.withOpacity(0.2),),
                              ),
                              padding: const EdgeInsets.only(bottom: 25),
                              child: const Center(child: Icon(Icons.play_circle, color: Colors.white,size: 45,),),
                            ),
                          ),

                          Positioned( bottom: 0, left: 0,right: 0, child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                                color: Theme.of(context).cardColor,
                                border: Border.all(color: Theme.of(context).shadowColor)
                            ),
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                            child: Column(children: [
                              Row( children: [

                                Expanded(
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Container(
                                      height: 17, width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        color: Theme.of(context).shadowColor,
                                      ),
                                    ),

                                    const SizedBox(height: Dimensions.paddingSizeSmall,),
                                    Container(
                                      height: 17, width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        color: Theme.of(context).shadowColor,
                                      ),
                                    ),

                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                                    Container(
                                      height: 17, width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        color: Theme.of(context).shadowColor,
                                      ),
                                    )
                                  ]),
                                ),

                                const SizedBox(width: Dimensions.paddingSizeLarge,),

                                InkWell(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall + 5, vertical: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                      color: Theme.of(context).shadowColor,
                                    ),
                                    child:  Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white.withOpacity(0.8),),
                                  ),
                                )
                              ],)
                            ],),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: Dimensions.paddingSizeLarge * 2,),

              Align(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    spacing: 5,
                    activeDotColor: Theme.of(context).disabledColor,
                    dotColor: Theme.of(context).hintColor.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
            ],
          ),
        ),
      ),
    );
  }
}



