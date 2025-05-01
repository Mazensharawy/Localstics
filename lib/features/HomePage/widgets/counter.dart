import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';

class CartItem extends StatefulWidget {
  final String image;
  final String title;
  final String size;
  final String price;

  const CartItem({
    super.key,
    required this.image,
    required this.title,
    required this.size,
    required this.price,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int counter = 1; // Each item has its own counter

  void increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void decreaseCounter() {
    setState(() {
      if (counter > 1) {
        counter--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightt),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5, top: 13, bottom: 13),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(widget.image, width: 110, height: 110, fit: BoxFit.cover),
            ),
            const Gap(18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.title, style: getTextStyle(fontweight: FontWeight.bold)),
                    const Gap(15),
                    IconButton(
                      onPressed: (){},
                      icon: Image.asset('assets/trash.png', width: 18, height: 18, fit: BoxFit.cover),
                    ),
                  ],
                ),
                Text('Size ${widget.size}', style: getTextStyle(color: AppColors.lightgrey)),
                const Gap(2),
                Row(
                  children: [
                    Text(widget.price, style: getTextStyle(fontweight: FontWeight.bold)),
                    const Gap(50),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: decreaseCounter,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black, style: BorderStyle.solid),
                            ),
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        const Gap(10),
                        Text(counter.toString(), style: getTextStyle()),
                        const Gap(10),
                        GestureDetector(
                          onTap: increaseCounter,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black, style: BorderStyle.solid),
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
