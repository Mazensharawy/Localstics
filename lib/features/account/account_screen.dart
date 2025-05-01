import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/core/widgets/logout_dialog.dart';
import 'package:localsticss/features/account/faqs_screen.dart';
import 'package:localsticss/features/account/help_screen.dart';
import 'package:localsticss/features/account/mydetails_screen.dart';
import 'package:localsticss/features/account/orders_screen.dart';

class AccountScreen extends StatefulWidget {
    final VoidCallback? onSwitchToSeller;
  const AccountScreen({super.key, this.onSwitchToSeller});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text('Account', 
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
        padding: const EdgeInsets.only(left: 12, right: 12, top:10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(),
              const Gap(10),
              AccountRow(text: 'Your Orders',imagePath: 'assets/Box.png',
               onTap: (){push(context, const MyOrdersScreen());}, textColor: AppColors.black,iconColor: AppColors.black,),
              const Gap(8),
              Divider(thickness: 10,color: AppColors.lightt,),
              const Gap(15),
              AccountRow(text: 'Account Info',
               onTap: (){push(context, const MyDetailsScreen());}, imagePath: 'assets/Info.png', textColor: AppColors.black, iconColor: AppColors.black,),
              const Gap(5),
              const Divider(),
              AccountRow(text: 'Rewards', onTap: (){}, imagePath: 'assets/Rewards.png', textColor: AppColors.black, iconColor: AppColors.black,),
              const Gap(5),
              const Divider(),
              AccountRow(text:'Saved Addresses', onTap: (){}, imagePath: 'assets/Address.png', textColor: AppColors.black,iconColor: AppColors.black,),
              const Gap(5),
              const Divider(),
              AccountRow(text: 'Payment Methods', onTap: (){}, imagePath: 'assets/Card.png', textColor: AppColors.black,iconColor: AppColors.black,),
              const Gap(5),
              const Divider(),
              AccountRow(text: 'Notifications', onTap: (){}, imagePath: 'assets/Bell.png', textColor: AppColors.black, iconColor: AppColors.black,),
              const Gap(12),
              Divider(thickness: 10,color: AppColors.lightt,),
              const Gap(15),
              AccountRow(text: 'FAQs', onTap: (){
                push(context, const FactsScreen());
              }, imagePath: 'assets/Question.png', textColor: AppColors.black, iconColor: AppColors.black,),
              const Divider(),
              AccountRow(text: 'Help Center', 
              onTap:(){ push(context, const HelpCenterScreen()); }, imagePath: 'assets/Help.png', textColor: AppColors.black, iconColor: AppColors.black,),
              const Gap(15),
              Divider(thickness: 10,color: AppColors.lightt,),
              const Gap(15),
              AccountRow(text: 'Convert to Seller', onTap:widget.onSwitchToSeller ?? () {}, imagePath:'assets/Convert.png', textColor: Colors.red, iconColor: Colors.transparent,),
              AccountRow(text: 'Logout', onTap:(){
                showLogoutDialog(context);
              }, imagePath:'assets/Logout.png', textColor: Colors.red, iconColor: Colors.transparent)
            ],
          ),
        ), 
      ),
    );
  }
}

class AccountRow extends StatelessWidget {
   final String text;
   final VoidCallback onTap;
   final String imagePath;
   final Color textColor;
   final Color iconColor;
  const AccountRow({
    super.key, required this.text, required this.onTap, required this.imagePath, required this.textColor, required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          children: [
            Row(
              children: [
                Image.asset(imagePath, width: 18,height: 18,),
                const Gap(15),
                Text(text, style: getTextStyle(color: textColor),),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: onTap,  
              icon: Icon(Icons.arrow_forward_ios, size: 20, color: iconColor,)),
          ],
        ),
      ),
    );
  }
}




