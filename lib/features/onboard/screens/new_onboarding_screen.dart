import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stackfood_multivendor/common/widgets/build_button_widget.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';
import 'package:stackfood_multivendor/util/images.dart';

import '../../../helper/address_helper.dart';
import '../../../helper/route_helper.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/onboard_controller.dart';

class NewOnboardingScreen extends StatelessWidget {
   NewOnboardingScreen({super.key});

  final PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    Get.find<OnBoardingController>().getOnBoardingList();
    return GetBuilder<OnBoardingController>(
      builder: (onBoardingController) {
        return Scaffold(
          body: Stack(
            fit: StackFit.passthrough,
            children: [

              // Background pattern
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.backgroundImg),
                    // Replace with your pattern image
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              // Skip button

              PageView.builder(
                  controller: _pageController,
                  itemCount: AppConstants.newOnBoarList.length,
                  onPageChanged: (index) {
                    onBoardingController.changeSelectIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Positioned(
                          bottom: 160,
                          left: MediaQuery.of(context).size.width / 3.3,
                         // right: MediaQuery.of(context).size.width / 1.2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              AppConstants.newOnBoarList[index].img!,
                              height: 320,
                            ),
                          ),
                        ),
                        // Main content
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 260,
                            child: Container(
                              //margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SmoothPageIndicator(
                                    controller: _pageController, // PageController
                                    count: OnBoardingController.newOnBoarLists.length,
                                    effect: ExpandingDotsEffect(
                                        dotColor: const Color(0xff898A8E),
                                        activeDotColor: Color(0xff7C0631),
                                        dotWidth: 18,
                                        dotHeight: 7),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    OnBoardingController.newOnBoarLists[index].txt!,
                                    style: TextStyle(
                                      color: Color(0xff7C0631),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    OnBoardingController.newOnBoarLists[index].des!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  BuildButtonWidget(
                                    txt: 'continue'.tr,
                                    onTap: () {
                                      if(onBoardingController.selectedIndex != 2) {
                                        _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                                      }else {
                                        _configureToRouteInitialPage();
                                      }
                                      // if (index == 2) {
                                      //   //PrefServices.saveData(key: "onBoard", value: true);
                                      //   Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (_) => LanguageScreen(
                                      //         fromMenu: true,
                                      //       ),
                                      //     ),
                                      //   );
                                      //   //Navigator.pushReplacementNamed(context, Routes.loginScreen);
                                      // } else {
                                      //   controller.nextPage(
                                      //       duration:
                                      //           const Duration(milliseconds: 200),
                                      //       curve: Curves.easeOut);
                                      // }
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              GestureDetector(
                onTap: () {
                  _configureToRouteInitialPage();
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (_) => NewLanguageScreen()));
                },
                child: Padding(
                  padding:  EdgeInsets.only(left: 20.w,top: 32.h,right: 20.w),
                  child: Text(
                    onBoardingController.selectedIndex == 2 ? '': 'skip'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      }
    );
  }


  List<Widget> _pageIndicators(OnBoardingController onBoardingController, BuildContext context) {
    List<Container> indicators = [];

    for (int i = 0; i < onBoardingController.newOnBoarList!.length; i++) {
      indicators.add(
        Container(
          width: i == onBoardingController.selectedIndex ? 24 : 7, height: 7,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.40),
            borderRadius: i == onBoardingController.selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }

  void _configureToRouteInitialPage() async {
    Get.find<SplashController>().disableIntro();
    await Get.find<AuthController>().guestLogin();
    if (AddressHelper.getAddressFromSharedPref() != null) {
      Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
    } else {
      Get.find<SplashController>().navigateToLocationScreen('splash', offNamed: true);
    }
  }


}
