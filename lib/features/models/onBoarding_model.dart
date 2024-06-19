import 'package:yab_yab_ai/core/utils/assets.dart';

class OnBoardingModel {
  String imagePath;
  String title;
  String subTitle;
  String nextBottom;

  OnBoardingModel({
    required this.title,
    required this.imagePath,
    required this.subTitle,
    required this.nextBottom,
  });

  static List<OnBoardingModel> onBoardingScreens = [
    OnBoardingModel(
        title: 'Chat with Ai',
        imagePath: 'assets/images/onBoarding1.png',
        subTitle: 'Get ready to explore the power of artificial intelligence with YabYab. Our AI chat is here to assist you, whether you need information, advice, or just a friendly conversation.' ,
        nextBottom: 'Next'
    ),
    OnBoardingModel(
        title: 'Make a lot of creations',
        imagePath: 'assets/images/onBoarding2.png',
        subTitle:'Explore the limitless possibilities of AI-assisted creation. Our tool harnesses the latest advancements in artificial intelligence to generate stunning visuals tailored to your creativity.' ,
        nextBottom: 'Next'),
    OnBoardingModel(
        title: 'Trans and Dic',
        imagePath: 'assets/images/onBoarding3.png',
        subTitle: 'Unlock the power of language with our AI-driven Translation and Dictionary . Whether you are traveling, learning a new language, or simply exploring words and meanings, we have got you covered.' ,
        nextBottom: 'Get Started')
  ];
}
