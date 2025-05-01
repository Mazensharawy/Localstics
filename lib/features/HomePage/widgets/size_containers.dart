import 'package:flutter/material.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';

class ProductSize extends StatelessWidget {
  final String text;
  final bool isSelected;
  const ProductSize({
    super.key, required this.text, required this.isSelected,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.black : Colors.transparent,
            border: Border.all(color: AppColors.black, style: BorderStyle.solid),
          ),
          width: 35,
          height: 35,
          child: Center(
            child: Text(text, style: getTextStyle(fontweight: FontWeight.bold, fontSize: 19,
              color: isSelected ? Colors.white : AppColors.black,),
            ),
          ),
        ),
      ],
    );
  }
}