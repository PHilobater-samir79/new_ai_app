import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_yab_ai/Yabyab_Ai_app.dart';
import 'package:yab_yab_ai/constans.dart';
import 'package:yab_yab_ai/core/local_data/catch_helper.dart';
import 'package:yab_yab_ai/core/local_data/services_locator.dart';
import 'package:yab_yab_ai/core/utils/strings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await getIt<CacheHelper>().cacheInit();
  MobileAds.instance.initialize();
  Gemini.init(apiKey: Constans.gemeniAPIKey,);
  runApp(const YabYabAiApp());
}
