import 'package:flutter/material.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';

class BlackButton extends StatelessWidget {
  final double width; 
  final double height;
  final String text;
  final VoidCallback? onPressed; 
  const BlackButton({
    super.key, required this.text, required this.width, required this.height, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
         style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.black,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      ),
        onPressed: onPressed, 
        child: Text(text,
         style: getTextStyle(color: Colors.white),
        ),
      ),
    );
  }
}