import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/widgets/black_button.dart';
import 'package:localstics/features/HomePage/widgets/payment_select.dart';
import 'package:localstics/features/cart/cart_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isClicked = false;
  String selectedPayment = 'Card';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text('Checkout',
         style: getTextStyle(fontSize: 24, fontweight: FontWeight.bold),
        ),
        leading: IconButton(
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            pop(context, const CartScreen());
          },
        ),
        actions: [
          SvgPicture.asset(
            'assets/chatbotsvg.svg',
            width: 30,
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 5),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Gap(10),
              Row(
                children: [
                  Text('Delivery Address',
                   style: getTextStyle(fontweight: FontWeight.bold, fontSize: 16),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){},
                    child: Text('Change',
                     style: getTextStyle(
                      color: AppColors.lightgrey,
                      fontweight: FontWeight.bold, 
                      fontSize: 15, 
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.lightgrey),
                    ),
                  ),
                ],
              ),
              const Gap(15),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Icon(Icons.location_on_outlined),
                  ),
                  const Gap(25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Home', style: getTextStyle(fontSize: 15, fontweight: FontWeight.bold),),
                      Text('925 S Chugach St #APT 10, Alaska 99645',
                       style: getTextStyle(color: AppColors.lightgrey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(12),
              const Divider(),
              const Gap(15),
              Text('Payment Method',
               style: getTextStyle(fontweight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(12),
              Row(
                children: [
                  PaymentOption(
                    label: 'Card',
                    icon: Icons.credit_card,
                    isSelected: selectedPayment == 'Card',
                    onTap: () {
                     setState(() {
                      selectedPayment = 'Card';
                    });
                  },
                  ),
                  const Gap(5),
                  PaymentOption(
                   label: 'Cash',
                   icon: Icons.money,
                   isSelected: selectedPayment == 'Cash',
                   onTap: () {
                     setState(() {
                       selectedPayment = 'Cash';
                    });
                  },
                  ),
                  const Gap(5),
                  PaymentOption(
                   label: 'Pay',
                   icon: Icons.apple,
                   isSelected: selectedPayment == 'Pay',
                   onTap: () {
                    setState(() {
                      selectedPayment = 'Pay';
                    });
                   },
                   ), 
                ],
              ),
              const Gap(15),
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.lightt),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/visa.png', fit: BoxFit.cover,height: 15,width: 45,),
                          const Gap(15),
                          Text('**** **** **** 2512',
                           style: getTextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Icon(Icons.mode_edit_outline_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(15),
              const Divider(),
              const Gap(25),
              Text('Order Summary',
               style: getTextStyle(fontweight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(20),
              Row(
                children: [
                  Text('Sub-total', 
                   style: getTextStyle(color: AppColors.lightgrey, fontSize: 16),
                  ),
                  const Spacer(),
                  Text('L.E 2,000',
                   style: getTextStyle(fontweight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const Gap(15),
              Row(
                children: [
                  Text('VAT(%)', 
                   style: getTextStyle(color: AppColors.lightgrey, fontSize: 16),
                  ),
                  const Spacer(),
                  Text('L.E 0.00',
                   style: getTextStyle(fontweight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const Gap(15),
              Row(
                children: [
                  Text('Shipping fee',
                   style: getTextStyle(color: AppColors.lightgrey, fontSize: 16),
                  ),
                  const Spacer(),
                  Text('L.E 80', 
                   style: getTextStyle(fontweight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const Gap(10),
              const Divider(),
              const Gap(10),
              Row(
                children: [
                  Text('Total',
                   style: getTextStyle(color: AppColors.lightgrey, fontSize: 16),
                  ),
                  const Spacer(),
                  Text('L.E 2,080',
                   style: getTextStyle(fontweight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('assets/promo.png',),
                        hintText: 'Enter promo code',
                        hintStyle: getTextStyle(
                          color: AppColors.lightgrey, 
                          fontSize: 15,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide (color: AppColors.lightt,),
                            borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide (color: AppColors.lightt,),
                            borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  BlackButton(width: 110, text: 'Add', height: 45, onPressed: (){},),
                ],
              ),
              const Gap(35),
              BlackButton(text: 'Place Order', width: double.infinity, height: 60,onPressed: (){},),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}

