import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/features/auth/screens/sign_up_screen.dart';
import 'package:stackfood_multivendor/main.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';
import 'package:stackfood_multivendor/util/images.dart';

import '../../../common/widgets/build_button_widget.dart';
import '../../../common/widgets/custom_snackbar_widget.dart';
import '../../../helper/responsive_helper.dart';
import '../../../util/dimensions.dart';
import '../controllers/localization_controller.dart';

class NewLanguageScreen extends StatefulWidget {
  const NewLanguageScreen({super.key});

  @override
  State<NewLanguageScreen> createState() => _NewLanguageScreenState();
}

class _NewLanguageScreenState extends State<NewLanguageScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("language"),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 128),
            SvgPicture.asset(Images.newLogo),
            SizedBox(height: 70),
            GetBuilder<LocalizationController>(
                builder: (localizationController) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeLarge,
                  mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                      ? Dimensions.paddingSizeLarge
                      : 0.01,
                  childAspectRatio: 2.5 / 2,
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: AppConstants.newLanguages.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      activeIndex = index;
                      setState(() {

                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xffFEFCE0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              AppConstants.newLanguages[index].imageUrl!),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            AppConstants.newLanguages[index].languageName!,
                            style: TextStyle(
                                color: Color(0xff1E1E1E), fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            Spacer(),
            GetBuilder<LocalizationController>(
                builder: (localizationController) {
              return BuildButtonWidget(
                txt: 'save'.tr,
                onTap: () {
                  if (localizationController.languages.isNotEmpty &&
                      localizationController.selectedLanguageIndex != -1) {
                    localizationController.setLanguage(
                      Locale(
                        AppConstants.newLanguages[activeIndex].languageCode!,
                        AppConstants.newLanguages[activeIndex].countryCode,
                      ),
                    );
                    preferences.setBool("isSelectLanguage", true);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()));
                    // Get.to(()=> SignUpScreen());
                  } else {
                    showCustomSnackBar('select_a_language'.tr);
                  }
                },
              );
            }),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
