import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';

class ProductEditScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductEditScreen({super.key, required this.product});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController categoryController;
  late TextEditingController unitController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  bool inStock = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product['name'] ?? '');
    descController = TextEditingController(text: widget.product['desc'] ?? 'From Thailand. Pure refined Rice');
    categoryController = TextEditingController(text: widget.product['category'] ?? 'Grains');
    unitController = TextEditingController(text: widget.product['unit'] ?? 'Kilogram');
    priceController = TextEditingController(text: widget.product['price'] ?? '');
    discountController = TextEditingController(text: widget.product['discount'] ?? '');
    inStock = widget.product['inStock'] ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    categoryController.dispose();
    unitController.dispose();
    priceController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Product Details',
          style: getTextStyle(
            fontweight: FontWeight.bold,
            fontSize: 24,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5,right: 16),
            child: Image.asset('assets/bag.png', width: 48, height: 48,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Center(
                child: CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage(widget.product['image'] ?? 'assets/polo.png'),
                ),
              ),
              const Gap(18),
              CustomTextField(controller: nameController, hint: 'Regular Fit Black Tshirt'),
              const Gap(10),
              CustomTextField(controller: descController, hint: 'H&M'),
              const Gap(10),
              CustomTextField(controller: categoryController, hint: 'Grains'),
              const Gap(10),
              CustomTextField(controller: unitController, hint: 'XS'),
              const Gap(10),
              CustomTextField(controller: priceController, hint: '5,000 L.E', keyboardType: TextInputType.number),
              const Gap(10),
              CustomTextField(controller: discountController, hint: 'Discount Price (Optional)', keyboardType: TextInputType.number),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Mark Product in stock',
                    style: getTextStyle(fontSize: 16,fontweight: FontWeight.w600 ),
                  ),
                  Switch(
                    value: inStock,
                    onChanged: (val) {
                      setState(() {
                        inStock = val;
                      });
                    },
                    activeColor: AppColors.black,
                  ),
                ],
              ),
              const Gap(24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    showProductAddedDialog(context);
                  },
                  child: Text('Save Product',
                    style: getTextStyle(
                      fontweight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.bgColor,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 216, 75, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    showDeleteConfirmationDialog(context);
                  },
                  child: Text('Delete Product',
                    style: getTextStyle(
                      fontweight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

void showProductAddedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: AppColors.bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.verified, size: 50),
            ),
            const Gap(10),
            Text('Product saved',
              style: getTextStyle( fontweight: FontWeight.w600,fontSize: 24),
            ),
            const Gap(8),
            Text('Your changes have been saved and are now visible to customers.',
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 15, color: AppColors.lightgrey),
            ),
            const Gap(22),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); 
                },
                child: Text('View', style: getTextStyle(fontSize: 17,color: AppColors.bgColor, fontweight: FontWeight.bold)),
              ),
            ),
            const Gap(10),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.lighticon),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Add more Product', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      backgroundColor: AppColors.bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.error_outline, color: Color(0xFFD32F2F), size: 50),
            ),
            const Gap(20),
            Text('Delete Product?',
              style: getTextStyle(fontSize: 24, fontweight: FontWeight.w600, color: const Color(0xFFD32F2F)),
            ),
            const Gap(8),
            Text('Are you sure you want to delete this\nproduct? You won\'t be able to undo this.',
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 16, color: AppColors.lightgrey),
            ),
            const Gap(22),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 75, 65),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); 
                },
                child: Text('Confirm', style: getTextStyle(fontSize: 17, color: AppColors.bgColor, fontweight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  const CustomTextField({super.key, required this.controller, required this.hint, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: getTextStyle(
          fontweight: FontWeight.w400,
          fontSize: 17,
          color: AppColors.lightgrey,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.lightt,),
        ),
      ),
    );
  }
}
