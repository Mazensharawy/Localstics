import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 25, right: 12),
          child: SvgPicture.asset('assets/search.svg'),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 29),
          child: SvgPicture.asset('assets/voice.svg'),
        ),
        hintText: 'Search for products...',
        hintStyle: getTextStyle(color: AppColors.lighticon, fontweight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide (color: AppColors.lighticon,),
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide (color: AppColors.lighticon,),
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
      ),
    );
  }
}