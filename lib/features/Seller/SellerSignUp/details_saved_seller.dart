import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/widgets/black_button.dart';
import 'package:localstics/features/Seller/orders/orders_seller.dart';

class DetailsSavedSheet extends StatelessWidget {
  const DetailsSavedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(12),
          Icon(Icons.verified, size: 60, color: AppColors.black),
          const Gap(16),
          Text(
            'Details Saved',
            style: getTextStyle(fontSize: 22, fontweight: FontWeight.bold),
          ),
          const Gap(8),
          Text(
            'Your details have been saved successfully',
            style: getTextStyle(fontSize: 15, color: AppColors.darkgrey),
            textAlign: TextAlign.center,
          ),
          const Gap(24),
          BlackButton(
            text: 'Wait for admin approval',
            width: double.infinity,
            height: 55,
            onPressed: () {
              push(context, const OrderSellerScreen());
            },
          ),
          const Gap(12),
        ],
      ),
    );
  }
}
