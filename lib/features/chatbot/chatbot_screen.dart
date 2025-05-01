import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/home_screen.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 38),
          child: Center(
            child: Text('Chatbot',
             style: getTextStyle(fontweight: FontWeight.bold, fontSize: 24),),
          ),
        ),
        leading: IconButton(
          onPressed: (){
            pop(context, const HomeScreen());
          }, 
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 18),
        child: Stack(
          children: [SingleChildScrollView(
            child: Column(
              children: [
                const Divider(),
                const Gap(5),
                Center(
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightt,
                    ),
                    child: Center(
                      child: Text('Today',
                       style: getTextStyle(fontSize: 14,),
                      ),
                    ),
                  ),
                ),
                const Gap(25),
                const MessageBot(text: 'Hello, good morning.', width: 180, height: 46,),
                const Gap(10),
                const MessageBot(
                  text: 'I am a Chatbot, is there anything I can help you with?',
                  width: 240, height: 75,
                ),
                const Gap(5),
                Row(
                  children: [
                    Text('10:41 pm',
                     style: getTextStyle(color: AppColors.lightgrey, fontSize: 13),
                    ),
                  ],
                ),
                const Gap(15),
                const MessageRightBot(
                  text: 'Hi, Im having problems with my order & payment.', 
                  height: 70, 
                  width: 230),
                const Gap(10),
                const MessageRightBot(
                  text: 'Can you help me?', 
                  height: 48, 
                  width: 200),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('10:50 pm',
                     style: getTextStyle(color: AppColors.lightgrey, fontSize: 14),
                    ),
                  ],
                ),
                const Gap(15),
                const MessageBot(
                  text: 'Of course...', 
                  height: 46, 
                  width: 140),
                const Gap(10),
                const MessageBot(
                  text: 'Can you tell me the problem you are having? so I can help solve it', 
                  height: 90, 
                  width: 230),
                const Gap(5),
                Row(
                  children: [
                    Text('10:51 pm', 
                     style: getTextStyle(color: AppColors.lightgrey, fontSize: 14),
                    ),
                  ],
                ),
                const Gap(90),
                const Divider(),
                
              ],
            ),
          ),
          Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                     width: double.infinity,
                     decoration: BoxDecoration(
                       color: AppColors.bgColor,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                              width: 300,
                              height: 48,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: Image.asset('assets/image.png',),
                                  hintText: 'Write your messsage',
                                  hintStyle: getTextStyle(
                                    color: AppColors.lightgrey, 
                                    fontSize: 15,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide (color: AppColors.lightt,),
                                      borderRadius: const BorderRadius.all(Radius.circular(12))
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide (color: AppColors.lightt,),
                              borderRadius: const BorderRadius.all(Radius.circular(12))
                        ),
                                ),
                              ),
                            ),
                            const Gap(5),
                          SizedBox(
                             width: 60,
                             height: 48,
                             child: ElevatedButton(
                              onPressed: (){}, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.black,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                            ),
                            ),
                              child: SvgPicture.asset('assets/voice.svg')
                              ),
                          ),
                      ],
                    ),
                  ),
                ),
          ]
        ),
      ),
    );
  }
}

class MessageBot extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  const MessageBot({
    super.key, required this.text, required this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.lightt,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10), bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Center(
              child: Text(text,
               style: getTextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class MessageRightBot extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  const MessageRightBot({
    super.key, required this.text, required this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10), bottomLeft: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Center(
              child: Text(text,
               style: getTextStyle(fontSize: 15, color: AppColors.bgColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}