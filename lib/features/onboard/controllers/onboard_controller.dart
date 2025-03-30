import 'package:flutter/material.dart';
import 'package:stackfood_multivendor/features/onboard/domain/models/onboarding_model.dart';
import 'package:stackfood_multivendor/features/onboard/domain/service/onboard_service_interface.dart';
import 'package:get/get.dart';

import '../../../util/images.dart';
import '../domain/models/new_on_boarding_model.dart';

class OnBoardingController extends GetxController implements GetxService {
  final OnboardServiceInterface onboardServiceInterface;
  OnBoardingController({required this.onboardServiceInterface});

  List<OnBoardingModel>? _onBoardingList;
  List<OnBoardingModel>? get onBoardingList => _onBoardingList;

   PageController pageController = PageController();
  List<NewOnBoar>? _newOnBoarList;
  List<NewOnBoar>? get newOnBoarList => _newOnBoarList;


  int get selectedIndex => _selectedIndex;
  int _selectedIndex = 0;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void getOnBoardingList() async {
    _onBoardingList = await onboardServiceInterface.getOnBoardingList();
    update();
  }

  // void getNewOnBoarList() {
  //   _newOnBoarList = [
  //     NewOnBoar(img: Images.phoneImg,txt: "kenz surprises",des: "It offers you many surprises and saves you money. Get the same meals with discounts starting from 50%."),
  //     NewOnBoar(img: Images.phoneImg,txt: "Try Kenz now",des: "Book your order early today or tomorrow, choose the appropriate branch and receive your food fresh and immediately"),
  //     NewOnBoar(img: Images.phoneImg,txt: " Participate with us",des: "Be part of preserving the environment and participate with us in the #LetItLast initiative to sustain the blessing"),
  //   ];
  //   update();
  // }

 static List<NewOnBoar> newOnBoarLists = [
   NewOnBoar(
       img: Images.onboard1,
       txt: "knz_surprises".tr,
       des:
       "It_offers_you_many_surprises".tr),
   NewOnBoar(
       img: Images.onboard2,
       txt: "Try_Knz_now".tr,
       des:
       "Book_your_order_early_today".tr),
   NewOnBoar(
       img: Images.onboard3,
       txt: "Participate_with_us".tr,
       des:
       "Be_part_of_preserving_the_environment".tr),
  // NewOnBoar(img: Images.phoneImg,txt: "kenz surprises",des: "It offers you many surprises and saves you money. Get the same meals with discounts starting from 50%."),
  // NewOnBoar(img: Images.phoneImg,txt: "Try Kenz now",des: "Book your order early today or tomorrow, choose the appropriate branch and receive your food fresh and immediately"),
  // NewOnBoar(img: Images.phoneImg,txt: " Participate with us",des: "Be part of preserving the environment and participate with us in the #LetItLast initiative to sustain the blessing"),
  ];

}