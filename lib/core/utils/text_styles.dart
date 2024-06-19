import 'package:flutter/material.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';

abstract class AppTextStyle {
  static const TextStyle styleRegularGrey20 = TextStyle(
    color: AppColors.greyColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Lora'
  );
  static const TextStyle styleRegularBlack30 = TextStyle(
    color: AppColors.blackColor,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lora'
  );
  static const TextStyle styleRegularGrey18 = TextStyle(
      color: AppColors.greyColor,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontFamily: 'Lora'
  );
}