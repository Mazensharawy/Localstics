import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';

class AddProductSuccessDialog extends StatelessWidget {
  final VoidCallback onView;
  final VoidCallback onAddMore;
  const AddProductSuccessDialog({super.key, required this.onView, required this.onAddMore});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.lightt,
                  borderRadius: BorderRadius.circular(34),
                ),
                child:const Center(
                  child: Icon(Icons.verified_rounded, size: 44),
                ),
              ),
              const Gap(28),
              Text('Product added',
                style: getTextStyle(
                  fontweight: FontWeight.w600,
                  fontSize: 20,),
              ),
              const Gap(10),
              Text(
                'Your Product has been added to the list\nand is visible to customers',
                textAlign: TextAlign.center,
                style: getTextStyle(
                  fontweight: FontWeight.w400,
                  fontSize: 15,
                  color: AppColors.lightgrey,
                ),
              ),
              const Gap(26),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onView,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent
                  ),
                  child: Text('View',
                    style: getTextStyle(
                      fontweight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: onAddMore,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.black, width: 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: Text('Add more Product',
                    style: getTextStyle(
                      fontweight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
