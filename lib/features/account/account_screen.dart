import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/core/widgets/logout_dialog.dart';
import 'package:localstics/features/account/faqs_screen.dart';
import 'package:localstics/features/account/help_screen.dart';
import 'package:localstics/features/account/mydetails_screen.dart';
import 'package:localstics/features/account/orders_screen.dart';
import 'package:localstics/features/Seller/SellerSignUp/details_saved_seller.dart';
import 'package:localstics/features/Seller/SellerSignUp/signup_seller_screen.dart';
import 'package:localstics/features/Seller/orders/orders_seller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:localstics/features/home/navbar_seller.dart';


class AccountScreen extends StatefulWidget {
    final VoidCallback? onSwitchToSeller;
  const AccountScreen({super.key, this.onSwitchToSeller});

  @override
  State<AccountScreen> createState() => _AccountScreenState();

}
  String userEmail = "";
class _AccountScreenState extends State<AccountScreen> {
    @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser;
  }



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
              AccountRow(text: 'Convert to Seller', onTap: () async {
                print('Convert to Seller tapped');
                // Get current user from Firebase Auth
                final firebaseUser = FirebaseAuth.instance.currentUser;
                print('Firebase user: [33m[1m[4m${firebaseUser?.email}[0m');
                if (firebaseUser == null) {
                  print('No Firebase user found, returning');
                  return;
                }
                try {
                  final supabase = Supabase.instance.client;
                  // Query Supabase user table to get user_id
                  final userRows = await supabase
                      .from('users')
                      .select('id')
                      .eq('email', firebaseUser.email ?? '')
                      .maybeSingle();
                  print('Supabase user row: $userRows');
                  if (userRows == null || userRows['id'] == null) {
                    print('No matching user in Supabase for email: ${firebaseUser.email}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User not found in database. Please contact support.')),
                    );
                    return;
                  }
                  final userId = userRows['id'];
                  print('Supabase user_id: $userId');
                  // Now check seller table for this user_id
                  final seller = await supabase
                      .from('seller')
                      .select('approve')
                      .eq('user_id', userId)
                      .maybeSingle();
                  print('Seller row: $seller');
                  if (context.mounted) {
                    if (seller != null) {
                      print('Seller row exists, checking approval...');
                      if (seller['approve'] == true) {
                        print('Seller is approved, navigating to OrderSellerScreen');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderSellerScreen(),
                          ),
                        );
                      } else {
                        print('Seller not approved, showing DetailsSavedSheetWithBack');
                        final dialogResult = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => PopScope(
                            canPop: false,
                            onPopInvoked: (didPop) {
                              print('Back arrow pressed in DetailsSavedSheetWithBack');
                              // Do not pop here!
                            },
                            child: DetailsSavedSheetWithBack(),
                          ),
                        );
                        // Do nothing here! Stay on AccountScreen
                      }
                    } else {
                      print('No seller row, navigating to SignBusinessInfoScreen');
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            print('Building SignBusinessInfoScreen');
                            return const SignBusinessInfoScreen();
                          },
                        ),
                      );
                      print('Returned from SignBusinessInfoScreen with result: $result');
                      // After signup, show waiting modal with back arrow
                      if (result == true && context.mounted) {
                        print('Showing DetailsSavedSheetWithBack after signup');
                        final dialogResult = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => PopScope(
                            canPop: false,
                            onPopInvoked: (didPop) {
                              print('Back arrow pressed in DetailsSavedSheetWithBack after signup');
                              // Do not pop here!
                            },
                            child: DetailsSavedSheetWithBack(),
                          ),
                        );
                        if (dialogResult == 'backToAccount') {
                          Navigator.of(context).pop(); // Pop SignBusinessInfoScreen, return to AccountScreen
                        }
                      }
                    }
                  } else {
                    print('Context not mounted after seller check');
                  }
                } catch (e, st) {
                  print('Error in Convert to Seller: $e\n$st');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Something went wrong. Please try again.')),
                  );
                }
              }, imagePath:'assets/Convert.png', textColor: Colors.red, iconColor: Colors.transparent,),
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
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          children: [
            Row(
              children: [
                Image.asset(imagePath, width: 18, height: 18,),
                const Gap(15),
                Text(text, style: getTextStyle(color: textColor),),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 20, color: iconColor),
          ],
        ),
      ),
    );
  }
}

class DetailsSavedSheetWithBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop('backToAccount');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: DetailsSavedSheet(),
        ),
      ),
    );
  }
}




