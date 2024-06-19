import 'package:flutter/material.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/core/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          title,
          style: AppTextStyle.styleRegularGrey20
              .copyWith(color: AppColors.primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.primaryColor,
          ),
        ));
  }
}
