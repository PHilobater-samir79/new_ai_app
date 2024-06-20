import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/core/utils/strings.dart';
import 'package:yab_yab_ai/core/utils/text_styles.dart';
import 'package:yab_yab_ai/features/screens/widgets/ads_container.dart';
import 'package:yab_yab_ai/features/screens/widgets/custom_app_bar.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final outPutController = TextEditingController();
  final inputController = TextEditingController();
  final translator = GoogleTranslator();
  String inputText = '';
  String inputLang = 'en';
  String outputLang = 'ar';
  Future<void> translateText() async {
    final translation =
        await translator.translate(inputText, from: inputLang, to: outputLang);
    setState(() {
      outPutController.text = translation.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(
              title: AppStrings.translator,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .17,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  'assets/images/trans.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                    value: inputLang,
                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text('Arabic'),
                      ),
                      DropdownMenuItem(
                        value: 'fr',
                        child: Text('French'),
                      ),
                      DropdownMenuItem(
                        value: 'es',
                        child: Text('Spanish'),
                      ),
                      DropdownMenuItem(
                        value: 'hi',
                        child: Text('Hindi'),
                      ),
                      DropdownMenuItem(
                        value: 'ru',
                        child: Text('Russian'),
                      ),
                      DropdownMenuItem(
                        value: 'pt',
                        child: Text('Portuguese'),
                      ),
                      DropdownMenuItem(
                        value: 'zh-cn',
                        child: Text('Chinese'),
                      ),
                      DropdownMenuItem(
                        value: 'it',
                        child: Text('Italian'),
                      ),
                      DropdownMenuItem(
                        value: 'de',
                        child: Text('German'),
                      ),
                      DropdownMenuItem(
                        value: 'ko',
                        child: Text('Korean'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        inputLang = value!;
                      });
                    }),
                const SizedBox(
                  width: 10,
                ),
                const Text('➡️'),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                    value: outputLang,
                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text('Arabic'),
                      ),
                      DropdownMenuItem(
                        value: 'fr',
                        child: Text('French'),
                      ),
                      DropdownMenuItem(
                        value: 'es',
                        child: Text('Spanish'),
                      ),
                      DropdownMenuItem(
                        value: 'hi',
                        child: Text('Hindi'),
                      ),
                      DropdownMenuItem(
                        value: 'ru',
                        child: Text('Russian'),
                      ),
                      DropdownMenuItem(
                        value: 'pt',
                        child: Text('Portuguese'),
                      ),
                      DropdownMenuItem(
                        value: 'zh-cn',
                        child: Text('Chinese'),
                      ),
                      DropdownMenuItem(
                        value: 'it',
                        child: Text('Italian'),
                      ),
                      DropdownMenuItem(
                        value: 'de',
                        child: Text('German'),
                      ),
                      DropdownMenuItem(
                        value: 'ko',
                        child: Text('Korean'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        outputLang = value!;
                      });
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    controller: inputController,
                    cursorColor: AppColors.blackColor,
                    maxLines: 5,
                    textAlign:
                        inputLang == 'ar' ? TextAlign.right : TextAlign.left,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: inputLang == 'ar'
                          ? 'اكتب هنا لترجمة'
                          : 'Write here to translate',
                    ),
                    onChanged: (value) {
                      setState(() {
                        inputText = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: translateText,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Translate',
                              style: AppTextStyle.styleRegularGrey18
                                  .copyWith(color: AppColors.whiteColor),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              outPutController.clear();
                              inputController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Clear',
                              style: AppTextStyle.styleRegularGrey18
                                  .copyWith(color: AppColors.whiteColor),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: outPutController,
                    maxLines: 5,
                    textAlign:
                        outputLang == 'ar' ? TextAlign.right : TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: outputLang == 'ar'
                          ? 'ترجمة هنا'
                          : 'Here we will translate for you',
                    ),
                    onChanged: (value) {
                      setState(() {
                        inputText = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const AdsContainer(),
          ],
        ),
      ),
    );
  }
}
