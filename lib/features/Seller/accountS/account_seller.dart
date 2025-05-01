import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/core/widgets/logout_dialog.dart';
import 'package:localstics/features/Seller/accountS/business_details.dart';
import 'package:localstics/features/Seller/accountS/settings_seller_screen.dart';
import 'package:localstics/features/Seller/products/notifications_screen.dart';
//import 'product_screen.dart' show ProductScreen, PlaceholderScreen, SellerAccountScreen;



class AccountSellerScreen extends StatefulWidget {
  final VoidCallback? onSwitchToCustomer;
  const AccountSellerScreen({super.key, this.onSwitchToCustomer});

  @override
  State<AccountSellerScreen> createState() => _AccountSellerScreenState();
}

class _AccountSellerScreenState extends State<AccountSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Profile',
          style: getTextStyle(
            fontSize: 24, fontweight: FontWeight.bold,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    push(context, const NotificationSellerScreen());},
                  child: SvgPicture.asset('assets/Bell.svg',width: 26,height: 26,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset('assets/bag.png',width: 48, height: 48,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightt),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                     CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.bgColor,
                      child: Icon(Icons.person, color: AppColors.darkgrey, size: 32),
                    ),
                    const Gap(12),
                    Text('Business Name',
                      style: getTextStyle(
                        fontweight: FontWeight.w600,
                        fontSize: 16,),
                    ),
                  ],
                ),
              ),
              const Gap(25),
              Text("Let's set up your business",
                style: getTextStyle(
                  fontSize: 15,fontweight: FontWeight.w500),
              ),
              const Gap(8),
              AccountMenuItem(
                icon: Icons.description_outlined,
                text: 'Business Details',
                onTap: () {
                  push(context, const BusinessDetailsScreen());},
              ),
              AccountMenuItem(
                icon: Icons.storefront_outlined,
                text: 'Store Management',
                onTap: () {},
              ),
              AccountMenuItem(
                icon: Icons.settings_outlined,
                text: 'Settings',
                onTap: () {
                  push(context, const AccountSettingsScreen());},
              ),
              const Gap(15),
              AccountMenuItem(
                icon: Icons.swap_horiz,
                text: 'Convert to Customer',
                onTap: widget.onSwitchToCustomer ?? () {},
                iconColor: Colors.red,
                textColor: Colors.red,
              ),
              AccountMenuItem(
                icon: Icons.logout,
                text: 'Log Out',
                onTap: () {
                  showLogoutDialog(context);
                },
                iconColor: Colors.red,
                textColor: Colors.red,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class AccountMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const AccountMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        splashColor: Colors.transparent,  
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.lightt),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor ?? Colors.black54, size: 23),
              const Gap(16),
              Text(
                text,
                style: getTextStyle(
                  color: textColor ?? AppColors.black,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
