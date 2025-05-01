import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/product_details.dart';

class ProductCard extends StatelessWidget {
   const ProductCard({super.key, required this.product});
   final Map<String, dynamic> product;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        push(context, const ProductDetails());
      },
      child: Card(
        color: AppColors.bgColor,
       shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
       ),
       elevation: 3,
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 170,
            width: double.infinity,
            child: 
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10),),
                child: Image.asset(product["image"],
                  fit: BoxFit.cover,
                ),
              ),
              
            
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Row(
                  children: [
                    Text(product["brand"],
                      style: getTextStyle(fontSize: 12, color: AppColors.lightgrey),
                    ),
                    const Gap(10),
                    const Icon(Icons.star, color: Colors.amber, size: 14,),
                    Text("${product['rating']} (${product['reviews']})",
                      style: getTextStyle(fontSize: 12,),
                    ),
                  ],
                ),
                const Gap(4),
                Text(product["title"], 
                  style: getTextStyle(fontweight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Gap(4),
                Row(
                  children: [
                    Text(product["price"],
                          style: getTextStyle(fontweight: FontWeight.bold)),
                    if (product.containsKey("discount"))
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(product["discount"],
                                style: getTextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
       ),
      ),
    );
  }
}