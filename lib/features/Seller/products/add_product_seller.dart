import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';
import 'package:localsticss/features/Seller/products/product_dialog.dart';

class AddProductSellerScreen extends StatefulWidget {
  const AddProductSellerScreen({super.key});

  @override
  State<AddProductSellerScreen> createState() => _AddProductSellerScreenState();
}

class _AddProductSellerScreenState extends State<AddProductSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        title: Text(
          'Add Product',
          style: getTextStyle(
            fontweight: FontWeight.bold,
            fontSize: 24,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/bag.png',
              width: 48,
              height: 48,

            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(15),
             const  CustomTextField(hint: 'Product Name'),
              const Gap(16),
              const CustomTextField(hint: 'Describe the Product', maxLines: 2),
              const Gap(16),
              const ImageUploadBox(),
              const Gap(16),
              const CustomTextField(hint: 'Product Category'),
              const Gap(16),
              const CustomTextField(hint: 'Product Unit'),
              const Gap(16),
              const CustomTextField(hint: 'Product Price (N)'),
              const Gap(16),
              const CustomTextField(hint: 'Discount Price (Optional)'),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mark Product in stock',
                    style: getTextStyle(
                      fontweight: FontWeight.w600,
                      fontSize: 16,),
                  ),
                  Switch(
                    value: false,
                    onChanged: (v) {},
                    activeColor: AppColors.black,
                  ),
                ],
              ),
              const Gap(25),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: BlackButton(
                  height: 50,
                  width: double.infinity,
                  text: 'Save Product',
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AddProductSuccessDialog(
                        onView: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(); // Go back to products page
                        },
                        onAddMore: () {
                          Navigator.of(context).pop(); // Dismiss dialog only
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  const CustomTextField({super.key, required this.hint, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                maxLines: maxLines,
                decoration: InputDecoration(
                      contentPadding:const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                  hintText: hint,
                  hintStyle: getTextStyle(color: AppColors.lighticon, fontSize: 17),
                  enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide (color: AppColors.lightt,),
                   borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide (color: AppColors.lightt,),
                   borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                ),
              );
  }
}



class ImageUploadBox extends StatelessWidget {
  const ImageUploadBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightt),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 38, color: AppColors.lighticon),
          const Gap(8),
          Text('Upload Product Image',
            style: getTextStyle(
              fontweight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.lighticon,
            ),
          ),
          const Gap(2),
          Text('jpg/png should be less than 5mb',
            style: getTextStyle(
              fontweight: FontWeight.w500,
              fontSize: 13,
              color: AppColors.lighticon,
            ),
          ),
        ],
      ),
    );
  }
}
