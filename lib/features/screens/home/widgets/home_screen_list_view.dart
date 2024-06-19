import 'package:flutter/material.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/features/screens/home/home_screens/dic_screen.dart';
import 'package:yab_yab_ai/features/screens/home/home_screens/gemini_screen.dart';
import 'package:yab_yab_ai/features/screens/home/home_screens/speech_screen.dart';
import 'package:yab_yab_ai/features/screens/home/home_screens/trans_screen.dart';

import '../../../../core/ads/interstital_ad.dart';

class HomeScreenListView extends StatelessWidget {
  List<String> containerImages = [
    'assets/images/gemini.png',
    'assets/images/trans.png',
    'assets/images/dic.png',
    'assets/images/speech.png',
  ];

  HomeScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: containerImages.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (index == 0) {
              InterstitialAdShow().showAd();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const GeminiScreen();
                },
              ));
            } else if (index == 1) {
              InterstitialAdShow().showAd();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const TranslationScreen();
                },
              ));
            } else if (index == 2) {
              InterstitialAdShow().showAd();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const DictionaryScreen();
                },
              ));
            } else if (index == 3) {
              InterstitialAdShow().showAd();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SpeechScreen();
                },
              ));
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .17,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                containerImages[index],
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    ));
  }
}
