import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/home_screen.dart';
import 'package:localstics/features/HomePage/reviews_screen.dart';
import 'package:localstics/features/HomePage/widgets/size_containers.dart';
import 'package:localstics/features/cart/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Color _iconColor = Colors.white;
  void _toggleColor() {
    setState(() {
      _iconColor = _iconColor == Colors.white ? Colors.red : Colors.white;
    });
  }
  String selectedSize = ''; // Stores selected size
  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bgColor,
        leading: IconButton(
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            pop(context, const HomeScreen());
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Text('Details',
             style: getTextStyle(fontSize: 24, fontweight: FontWeight.bold),
             
            ),
          ),
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
      body: Stack(
        children: [
          SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/hoodie.png', 
                          width: double.infinity,
                          height: 380,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightt, 
                            shape: BoxShape.circle,
                    ),
                          child: IconButton(
                              icon: const Icon(Icons.favorite), 
                              color:_iconColor, 
                              iconSize: 26,
                              highlightColor: Colors.transparent,
                              onPressed: _toggleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Oversized Hoodie',
                  style: getTextStyle(fontSize: 23, fontweight: FontWeight.w600),
                ),
                const Gap(2),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 19,),
                    const Gap(4),
                    Text('4.0/5',
                      style: getTextStyle(fontSize: 15),
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: (){push(context, const ReviewsScreen());},
                      child: Text('(45 reviews)',
                        style: getTextStyle(fontSize: 15, color: AppColors.lightgrey),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  children: [
                    Expanded(
                      child: Text('The name says it all, the right size slightly snugs the body leaving enough room for comfort in the sleeves and waist.',
                       style: getTextStyle(color: AppColors.lightgrey),
                       softWrap: true,
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Text('Choose size',
                 style: getTextStyle(
                  fontweight: FontWeight.bold,fontSize: 19,
                 ),
                ),
                const Gap(5),
                 Row(
                  children: [
                    ...sizes.map((size){
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: ProductSize(
                            text: size, 
                            isSelected: selectedSize == size),
                        ),
                      );
                    }),
                  ],
                ),
                const Gap(60),
                const Divider(),
                
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.bgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, top: 5),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Price', style: getTextStyle(color: AppColors.lightgrey),),
                      Text('L.E  499', 
                        style: getTextStyle(fontweight: FontWeight.bold, fontSize: 23),
                      ),
                    ],
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: (){push(context, const CartScreen());},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 55, right: 55),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    ), 
                    child: Row(
                      children: [
                        Image.asset('assets/cartbag.png', width: 19,height: 19,),
                        const Gap(10),
                        Text('Add to Cart',
                          style: getTextStyle(color: AppColors.bgColor, fontSize: 20),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
        ]
      ),
    );
  }
}


