import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Settings',
          style: getTextStyle(
            fontSize: 24,
            fontweight: FontWeight.bold,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset('assets/bag.png',width: 48,height: 48,
                ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Icon(
              Icons.verified_outlined,
              size: 80,
              color: Colors.black,
            ),
            const Gap(18),
            Text('Password Reset\nSuccessful',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 18,
                fontweight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
