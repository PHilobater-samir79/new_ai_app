import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_yab_ai/core/ads/ads.dart';

class AdsContainer extends StatefulWidget {
  const AdsContainer({super.key});

  @override
  State<AdsContainer> createState() => _AdsContainerState();
}

class _AdsContainerState extends State<AdsContainer> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  void adLoad() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdManger.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: AdRequest())
      ..load();
  }

  @override
  void initState() {
    adLoad();
    super.initState();
  }

  @override
  void dispose() {
    if (isLoaded) {
      bannerAd!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: isLoaded
            ? SizedBox(
                width: bannerAd!.size.width.toDouble(),
                height: bannerAd!.size.height.toDouble(),
                child: AdWidget(
                  ad: bannerAd!,
                ),
              )
            : const SizedBox());
  }
}
