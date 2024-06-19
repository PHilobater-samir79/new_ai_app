import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/core/utils/text_styles.dart';
import 'package:yab_yab_ai/features/screens/widgets/ads_container.dart';
import 'package:yab_yab_ai/features/screens/widgets/custom_app_bar.dart';

import '../../../../core/utils/strings.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speech = SpeechToText();
  bool isListening = false;
  String words = '';

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    bool available = await speech.initialize();
    if (!mounted) return;
    setState(() {
      isListening = available;
    });
  }

  void startListening() async {
    await speech.listen(
      onResult: (result) {
        setState(() {
          words = result.recognizedWords;
        });
      },
      localeId: 'ar_SA',
    );
    await speech.listen(
      onResult: (result) {
        setState(() {
          words = result.recognizedWords;
        });
      },
      localeId: 'en_US',
    );
    setState(() {
      isListening = true;
    });
  }

  void stopListening() async {
    await speech.stop();
    setState(() {});
  }

  void copyText() {
    Clipboard.setData(ClipboardData(text: words));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(AppStrings.copied),
    ));
  }

  void clearText() {
    setState(() {
      words = '';
    });
  }

  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(
              title: AppStrings.speechToText,
            ),
            words.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .17,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        'assets/images/speech.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IntrinsicHeight(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            words,
                            style: AppTextStyle.styleRegularGrey18
                                .copyWith(color: AppColors.blackColor),
                          ),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            words.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: copyText,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blackColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: Text(
                                'Copy',
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: clearText,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: Text(
                                'Clear',
                                style: TextStyle(color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            CircleAvatar(
                radius: 40,
                backgroundColor:
                    words.isEmpty ? AppColors.primaryColor : Colors.red,
                child: IconButton(
                    onPressed: () {
                      if (words.isEmpty) {
                        startListening();
                      } else {
                        stopListening();
                        setState(() {
                          words = '';
                        });
                      }
                    },
                    icon: Icon(
                      isListening ? Icons.mic : Icons.mic_none,
                      color: AppColors.whiteColor,
                      size: 30,
                    ))),
            const SizedBox(
              height: 20,
            ),
            const AdsContainer(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
