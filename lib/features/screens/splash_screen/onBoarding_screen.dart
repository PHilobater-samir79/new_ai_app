import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yab_yab_ai/core/local_data/catch_helper.dart';
import 'package:yab_yab_ai/core/local_data/services_locator.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/core/utils/strings.dart';
import 'package:yab_yab_ai/core/utils/text_styles.dart';
import 'package:yab_yab_ai/features/models/onBoarding_model.dart';
import 'package:yab_yab_ai/features/screens/home/home_screen.dart';
import 'package:yab_yab_ai/features/screens/splash_screen/splash_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  int currentIndex = 0;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              isLastPage
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        controller.jumpToPage(2);
                      },
                      child: const Text(AppStrings.skip,
                          style: AppTextStyle.styleRegularGrey20),
                    ),
              isLastPage
                  ? SizedBox(
                      height: height * .09,
                    )
                  : SizedBox(
                      height: height * .06,
                    ),
              Expanded(
                  child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                        if (value + 1 ==
                            OnBoardingModel.onBoardingScreens.length) {
                          setState(() {
                            isLastPage = true;
                          });
                        } else {
                          setState(() {
                            isLastPage = false;
                          });
                        }
                      },
                      controller: controller,
                      itemCount: OnBoardingModel.onBoardingScreens.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Image.asset(
                            OnBoardingModel.onBoardingScreens[index].imagePath,
                            height: 250,
                            width: 250,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: const WormEffect(
                                activeDotColor: AppColors.primaryColor,
                                dotHeight: 8,
                                dotColor: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            OnBoardingModel.onBoardingScreens[index].title,
                            style: AppTextStyle.styleRegularBlack30,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: width,
                            child: Text(
                              OnBoardingModel.onBoardingScreens[index].subTitle,
                              style: AppTextStyle.styleRegularGrey18,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: width * .8,
                            child: ElevatedButton(
                              onPressed: () async {
                                await getIt<CacheHelper>()
                                    .setData(key: 'isVisited', value: true)
                                    .then((value) {
                                  index == 2
                                      ? Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                          builder: (context) {
                                            return const HomeScreen();
                                          },
                                        ))
                                      : controller.nextPage(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          curve:
                                              Curves.fastEaseInToSlowEaseOut);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.whiteColor,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                child: Text(
                                  OnBoardingModel
                                      .onBoardingScreens[index].nextBottom,
                                  style: AppTextStyle.styleRegularGrey20
                                      .copyWith(
                                          fontSize: 22, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ]);
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
