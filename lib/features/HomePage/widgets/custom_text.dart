
import 'package:flutter/material.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/category_screen.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key, required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, 
           style: getTextStyle(fontweight: FontWeight.bold, fontSize: 21),),
        const Spacer(),
        GestureDetector(
                      onTap: () {
                        push(context, const CategoryScreen());
                      },
                      child: Text('See All', 
                        style: getTextStyle(color: AppColors.darkgrey, fontSize: 15),))
      ],
    );
  }
}