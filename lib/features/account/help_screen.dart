import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/account/account_screen.dart';
import 'package:localstics/features/account/contact_screen.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(  
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: (){
            pop(context, const AccountScreen());
          }, 
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        title: Text('Help Center', 
         style: getTextStyle(fontweight: FontWeight.bold, fontSize: 24),),
        actions: [
          SvgPicture.asset(
            'assets/chatbotsvg.svg',
            width: 30,
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,
            ),
          ),
        ],
      ),
      body: Padding(
        padding:  const EdgeInsets.only(left: 17, right: 17),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Gap(27),
              HelpContainer(text: 'Contact Us', imagePath: 'assets/Help.png', onTap: (){
                push(context, const ContactUsScreen());},height: 20,),
              const Gap(14),
              HelpContainer(text: 'Whatsapp', imagePath: 'assets/Whatsapp.png', onTap:(){}, height: 20,),
              const Gap(14),
              HelpContainer(text:'Website', imagePath:'assets/Web.png', onTap:(){}, height: 20,),
              const Gap(14),
              HelpContainer(text: 'Facebook', imagePath:'assets/Facebokkk.png', onTap:(){}, height: 20,),
              const Gap(14),
              HelpContainer(text: 'Twitter', imagePath:'assets/Twitter.png', onTap:(){}, height: 20,),
              const Gap(14),
              HelpContainer(text: 'Instagram', imagePath:'assets/Instagram.png', onTap:(){}, height: 20,),
              const Gap(14),
              HelpContainer(text: 'About Localstics', imagePath:'assets/bag.png', onTap:(){}, height: 28,),
            ],
          ),
        ),
        ),
    );
  }
}

class HelpContainer extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;
  final double height;
  const HelpContainer({
    super.key, required this.text, required this.imagePath, required this.onTap, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightt),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 45),
          child: Row(
            children: [
              Image.asset(imagePath, fit: BoxFit.cover, width: height,height: height,),
              const Gap(10),
              Text(text, style: getTextStyle(fontSize: 17, fontweight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }
}