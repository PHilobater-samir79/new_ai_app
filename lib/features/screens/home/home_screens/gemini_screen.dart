import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:yab_yab_ai/core/utils/colors.dart';
import 'package:yab_yab_ai/core/utils/text_styles.dart';

import '../../../../core/utils/strings.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  final Gemini gemini = Gemini.instance;
  ChatUser currentUser = ChatUser(
    id: '0',
    firstName: 'YabYab',
  );
  ChatUser gemeniUser = ChatUser(
      id: '1',
      firstName: 'Gemini',
      profileImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMILGvod4Xk3Ha4kIqe3XEubnjiskQ3y4M7w&s');
  List<ChatMessage> messages = [];
  void onSend(ChatMessage message) {
    setState(() {
      messages = [message, ...messages];
    });
    try {
      String question = message.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == gemeniUser) {
          lastMessage = messages.removeAt(0);
          String? response = event.content?.parts?.fold(
                '',
                (previous, current) => '$previous ${current.text}',
              ) ??
              "";
          lastMessage.text += response ?? "";
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String? response = event.content?.parts?.fold(
                '',
                (previous, current) => '$previous ${current.text}',
              ) ??
              "";
          ChatMessage? message = ChatMessage(
              user: gemeniUser,
              createdAt: DateTime.now(),
              text: response ?? "");
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            AppStrings.gemini,
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
          )),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
        child: DashChat(
            messageOptions: const MessageOptions(
                currentUserContainerColor: AppColors.blackColor,
                currentUserTextColor: AppColors.whiteColor,
            ),
            currentUser: currentUser, onSend: onSend, messages: messages),
      ),
    );
  }
}
