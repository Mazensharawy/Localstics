import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';
import 'package:localsticss/features/account/help_screen.dart';
import 'package:localsticss/features/recycle/recycle_screen.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: (){
            pop(context, const HelpCenterScreen());
          }, 
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15), 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact Us',
               style: getTextStyle(fontSize: 26, fontweight: FontWeight.bold),),
               Text('We\'re here to help you anytime!',
               style: getTextStyle(color: AppColors.lightgrey, fontSize: 15),),
               const Gap(20),
               const RecycleForm(text: 'Full Name', label: 'Enter your full name'),
               const RecycleForm(text: 'Email', label: 'Enter your email address'),
               const RecycleForm(text: 'Your Message', label: 'Enter your message'),
               const Gap(8),
              Text('By submitting you agree that your data is being collected and stored.',
               style: getTextStyle(fontSize: 15, fontweight: FontWeight.bold),
              ),
              const Gap(18),
              BlackButton(text: 'Send Message', width: double.infinity, height: 60,
               onPressed: () {},),
              const Gap(22),
              Row(
               children: [
                Expanded(
                  child: Divider(
                   color: AppColors.lightt, 
                   thickness: 1, 
                   endIndent: 15, 
                   ),
                   ),
                Text("OR",
                   style: getTextStyle(
                   color: AppColors.lighticon,
                   fontweight: FontWeight.bold, fontSize: 13,
                   ),
                   ),
                Expanded(
                  child: Divider(
                   color: AppColors.lightt, 
                   thickness: 1,
                   indent: 15,),
                  ),
                ],
                ),
                const Gap(22),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),),
                    ),
                    onPressed: (){}, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png', fit: BoxFit.cover,),
                        const Gap(10),
                        Text('Sign Up with Google', style: getTextStyle(),),
                      ],
                    )),
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),),
                    ),
                    onPressed: (){}, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/facebook.png', fit: BoxFit.cover,),
                        const Gap(10),
                        Text('Sign Up with Facebook', style: getTextStyle(color: AppColors.bgColor),),
                      ],
                    )),
                ),
                const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}