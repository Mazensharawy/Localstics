import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/counter.dart';
import 'package:localsticss/features/cart/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text('My Cart',
         style: getTextStyle(fontSize: 24, fontweight: FontWeight.bold),
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
              const CartItem(
                image: 'assets/polo.png',
                title: 'Regular Fit Slogan',
                size: 'L',
                price: 'L.E 499',
              ),
              const Gap(8),
               const CartItem(
                image: 'assets/blacktee.png',
                title: 'Regular Fit Tshirt',
                size: 'L',
                price: 'L.E 499',
              ),
              const Gap(8),
               const CartItem(
                image: 'assets/hoodie.png',
                title: 'Oversized Hoodie',
                size: 'L',
                price: 'L.E 499',
              ),
              const Gap(30),
              Row(
                children: [
                  Text('Sub-total', 
                   style: getTextStyle(color: AppColors.lightgrey),
                  ),
                  const Spacer(),
                  Text('L.E 2,000',
                   style: getTextStyle(fontweight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Text('VAT(%)', 
                   style: getTextStyle(color: AppColors.lightgrey),
                  ),
                  const Spacer(),
                  Text('L.E 0.00',
                   style: getTextStyle(fontweight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Text('Shipping fee',
                   style: getTextStyle(color: AppColors.lightgrey),
                  ),
                  const Spacer(),
                  Text('L.E 80', 
                   style: getTextStyle(fontweight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(10),
              const Divider(),
              const Gap(10),
              Row(
                children: [
                  Text('Total',
                   style: getTextStyle(color: AppColors.lightgrey),
                  ),
                  const Spacer(),
                  Text('L.E 2,080',
                   style: getTextStyle(fontweight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(30),
              ElevatedButton(
                    onPressed: (){
                      push(context, const CheckoutScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 55, right: 55),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    ), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Go To Checkout',
                          style: getTextStyle(color: AppColors.bgColor, fontSize: 20),
                        ),
                        const Gap(10),
                        Icon(Icons.arrow_forward, color: AppColors.bgColor,),
                      ],
                    ),
                  ),
                  const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}