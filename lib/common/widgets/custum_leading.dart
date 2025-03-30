import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/images.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading({super.key, this.isHelp});
  final Color? isHelp;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Image.asset(
        Images.arrowLeft1,
        color: isHelp != null ? isHelp : null,
      ),
    );
  }
}
