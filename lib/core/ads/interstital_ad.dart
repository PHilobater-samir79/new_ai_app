import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_yab_ai/core/ads/ads.dart';

class InterstitialAdShow {
  InterstitialAd? interstitialAd;

  void showAd() {
    InterstitialAd.load(
        adUnitId: AdManger.interstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if (interstitialAd != null) {
              interstitialAd!.show();
            }
            ad.fullScreenContentCallback = FullScreenContentCallback(
             onAdDismissedFullScreenContent: (ad) {
               ad.dispose();
             },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            if (kDebugMode) {
              print(error.toString());
            }
          },
        ));
  }
}
