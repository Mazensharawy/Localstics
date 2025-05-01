import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Can't dismiss by tapping outside
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(20),
        backgroundColor: AppColors.bgColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 62,
              color: Colors.red,
            ),
            const Gap(8),
            Text('Logout?',
              style: getTextStyle(
                fontSize: 26,
                fontweight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Text('Are you sure you want to logout?',
              style: getTextStyle(
                fontSize: 16, color: AppColors.darkgrey,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Yes, Logout',
                style: getTextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const Gap(10),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.lightt),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('No, Cancel',
                style: getTextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      );
    },
  );
}
