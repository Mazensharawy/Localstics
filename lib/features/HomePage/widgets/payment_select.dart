import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';

class PaymentOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call parent function to update selected payment
      child: Container(
        width: 120,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.black : AppColors.bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightt),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
                size: 18,
              ),
              const Gap(5),
              Text(
                label,
                style: getTextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
