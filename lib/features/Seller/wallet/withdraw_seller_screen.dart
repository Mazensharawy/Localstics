import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';
import 'package:localsticss/features/Seller/wallet/withdrawpin_seller_screen.dart';

class WithdrawSellerScreen extends StatefulWidget {
  const WithdrawSellerScreen({super.key});

  @override
  State<WithdrawSellerScreen> createState() => _WithdrawSellerScreenState();
}

class _WithdrawSellerScreenState extends State<WithdrawSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(15),
              Text('Withdrawal',
                style: getTextStyle(
                  fontweight: FontWeight.w600,
                  fontSize: 20,),
              ),
              const Gap(30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.lightt),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: InputBorder.none,
                    hintText: 'Amount',
                    hintStyle: getTextStyle(
                      fontweight: FontWeight.w400,
                      color: AppColors.darkgrey,
                      fontSize: 15,),
                  ),
                  style: getTextStyle(
                    fontweight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const Gap(30),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.lightt)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Access Bank',
                            style: getTextStyle(
                              fontweight: FontWeight.w400,
                              fontSize: 17,),
                          ),
                          Text('Emeka Festus Akanbi',
                            style: getTextStyle(
                              fontweight: FontWeight.w400,
                              color: AppColors.darkgrey,
                              fontSize: 13,),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Icon(Icons.arrow_forward_ios, size: 19, color: AppColors.lighticon,),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Row(
                children:  [
                  const Icon(Icons.add, size: 19),
                  const Gap(8),
                  Text('Add Bank',
                    style: getTextStyle(
                      fontweight: FontWeight.w600,
                      fontSize: 15,),
                  ),
                ],
              ),
              const Spacer(),
              BlackButton(text: 'Withdraw', width: double.infinity, height: 48, onPressed: (){
                push(context, const WithdrawPinScreen());
              },),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
