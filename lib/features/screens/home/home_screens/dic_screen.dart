import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yab_yab_ai/core/networking/dic_api_maneger.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/core/utils/strings.dart';
import 'package:yab_yab_ai/core/utils/text_styles.dart';
import 'package:yab_yab_ai/features/screens/widgets/ads_container.dart';
import 'package:yab_yab_ai/features/screens/widgets/custom_app_bar.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loadData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          const CustomAppBar(
            title: AppStrings.dictionary,
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
                'assets/images/dic.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter text';
                        }
                        return null;
                      },
                      controller: textController,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.blackColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppColors.primaryColor),
                        ),
                        labelText: 'Search',
                        labelStyle: AppTextStyle.styleRegularGrey18,
                        suffix: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              setState(() {
                                loadData = true;
                              });
                            }
                          },
                          child: Text(
                            'Search',
                            style: AppTextStyle.styleRegularGrey18
                                .copyWith(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          const AdsContainer(),
          const SizedBox(
            height: 10,
          ),
          loadData == false || textController.text.isEmpty
              ? const SizedBox()
              : FutureBuilder(
                  future: DicApiManger().getDicData(text: textController.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 2,
                                        color: AppColors.primaryColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.greyColor,
                                          border: Border.all(
                                              color: AppColors.greyColor,
                                              width: .5)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Expanded(
                          child: Center(child: Text('Please search again')));
                    }
                    final wordData = snapshot.data;
                    final List meanings = wordData!['meanings'] ?? [];
                    return Expanded(
                      child: ListView.builder(
                        itemCount: meanings.length,
                        itemBuilder: (context, index) {
                          final meaning = meanings[index];
                          final String partsOfSpeech =
                              meaning['partOfSpeech'] ?? '';
                          final List synonyms = meaning['synonyms'] ?? [];
                          final List antonyms = meaning['antonyms'] ?? [];
                          final List definitions = meaning['definitions'] ?? [];
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1, color: AppColors.primaryColor),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      partsOfSpeech,
                                      style: AppTextStyle.styleRegularGrey18
                                          .copyWith(
                                              color: AppColors.blackColor),
                                    ),
                                    if (definitions.isNotEmpty)
                                      ...definitions.map((defination) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              defination['definition'] ?? "",
                                              style: AppTextStyle
                                                  .styleRegularGrey18
                                                  .copyWith(
                                                      color:
                                                          AppColors.blackColor),
                                            ),
                                            if (defination['example'] != null)
                                              Text(
                                                'Example: ${defination['example']}',
                                                style: AppTextStyle
                                                    .styleRegularGrey18
                                                    .copyWith(
                                                        color: AppColors
                                                            .blackColor),
                                              ),
                                          ],
                                        );
                                      }),
                                    if (synonyms.isNotEmpty)
                                      Text(
                                        'Synonyms: ${synonyms.join(', ')}',
                                        style: AppTextStyle.styleRegularGrey18
                                            .copyWith(
                                                color: AppColors.blackColor),
                                      ),
                                    if (antonyms.isNotEmpty)
                                      Text(
                                        'Antonyms: ${antonyms.join(', ')}',
                                        style: AppTextStyle.styleRegularGrey18
                                            .copyWith(
                                                color: AppColors.blackColor),
                                      ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
