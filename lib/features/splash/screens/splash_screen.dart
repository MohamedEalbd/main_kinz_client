import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stackfood_multivendor/common/widgets/no_internet_screen_widget.dart';
import 'package:stackfood_multivendor/features/auth/controllers/auth_controller.dart';
import 'package:stackfood_multivendor/features/auth/screens/sign_in_screen.dart';
import 'package:stackfood_multivendor/features/cart/controllers/cart_controller.dart';
import 'package:stackfood_multivendor/features/favourite/controllers/favourite_controller.dart';
import 'package:stackfood_multivendor/features/home/screens/home_screen.dart';
import 'package:stackfood_multivendor/features/notification/domain/models/notification_body_model.dart';
import 'package:stackfood_multivendor/features/splash/controllers/splash_controller.dart';
import 'package:stackfood_multivendor/features/splash/domain/models/deep_link_body.dart';
import 'package:stackfood_multivendor/helper/address_helper.dart';
import 'package:stackfood_multivendor/helper/maintance_helper.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';
import 'package:stackfood_multivendor/main.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';
import 'package:stackfood_multivendor/util/dimensions.dart';
import 'package:stackfood_multivendor/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../address/screens/new_address_screen.dart';
import '../../auth/screens/sign_up_screen.dart';
import '../../language/screens/new_language_screen.dart';
import '../../onboard/screens/new_onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBodyModel? notificationBody;
  final DeepLinkBody? linkBody;

  const SplashScreen(
      {super.key, required this.notificationBody, required this.linkBody});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<List<ConnectivityResult>>? _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      bool isConnected = result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile);

      if (!firstTime) {
        ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          backgroundColor: isConnected ? Colors.green : Colors.red,
          duration: Duration(seconds: isConnected ? 3 : 6000),
          content: Text(isConnected ? 'connected'.tr : 'no_connection'.tr,
              textAlign: TextAlign.center),
        ));
        if (isConnected) {
          _route();
        }
      }

      firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    if (AddressHelper.getAddressFromSharedPref() != null &&
        (AddressHelper.getAddressFromSharedPref()!.zoneIds == null ||
            AddressHelper.getAddressFromSharedPref()!.zoneData == null)) {
      AddressHelper.clearAddressFromSharedPref();
    }
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.find<AuthController>().isGuestLoggedIn() ||
          Get.find<AuthController>().isLoggedIn()) {
        Get.find<CartController>().getCartDataOnline();
      }
      _route();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged?.cancel();
  }

  void _route() {
    // //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewOnboardingScreen()));
    // if (preferences.getBool("onBoard") == true) {
    //   if (preferences.getBool("isSelectLanguage") == true) {
    //     if (preferences.getBool("login") == true) {
    //       if(preferences.getBool("location")==true){
    //         Get.to(()=>HomeScreen());
    //       }else{
    //         Get.to(()=>NewAddressScreen());
    //       }
    //
    //
    //     } else {
    //       Get.to(() => SignUpScreen());
    //     }
    //   } else {
    //     Get.to(() => NewLanguageScreen());
    //   }
    // } else {
      Get.find<SplashController>().getConfigData(
        handleMaintenanceMode: false,
        notificationBody: widget.notificationBody,
      );
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.hasConnection
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Images.newLogo),
                    // Image.asset(Images.logo, width: 100),
                    const SizedBox(height: Dimensions.paddingSizeLarge),

                    Image.asset(Images.logoName, width: 150),
                  ],
                )
              : NoInternetScreen(
                  child: SplashScreen(
                      notificationBody: widget.notificationBody,
                      linkBody: widget.linkBody)),
        );
      }),
    );
  }
}
