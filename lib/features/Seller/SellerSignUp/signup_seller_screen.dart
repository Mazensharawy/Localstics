import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/widgets/black_button.dart';
import 'package:localstics/features/Seller/SellerSignUp/details_saved_seller.dart';

class SignBusinessInfoScreen extends StatefulWidget {
  const SignBusinessInfoScreen({super.key});

  @override
  State<SignBusinessInfoScreen> createState() => _SignBusinessInfoScreenState();
}

class _SignBusinessInfoScreenState extends State<SignBusinessInfoScreen> {
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _socialMediaController = TextEditingController();

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _socialMediaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              'assets/bag.png',
              width: 48,
              height: 48,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 85,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text('Business Information',
                          style: getTextStyle(
                            fontweight: FontWeight.bold,fontSize: 22,
                          ),),
                        Text('Provide your business details',
                          style: getTextStyle(
                            fontSize: 14,
                          ),),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.camera_alt, color: Colors.grey.shade700, size: 30),
                  ),
                ),
              ),
              Text('Store Name', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
              const Gap(3),
              _buildShadowedField(
                controller: _storeNameController,
                hintText: 'Your Store Name',
                isMultiline: false,
              ),
              const Gap(15),
              Text('Description', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
              const Gap(3),
              _buildShadowedField(
                controller: _descriptionController,
                hintText: 'Describe your business...',
                isMultiline: true,
              ),
              const Gap(15),
              Text('Phone Number', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
              const Gap(3),
              _buildShadowedField(
                controller: _phoneController,
                hintText: 'Official Phone Number',
                isMultiline: false,
                keyboardType: TextInputType.phone,
              ),
              const Gap(15),
              Text('Social Media Link', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
              const Gap(3),
              _buildShadowedField(
                controller: _socialMediaController,
                hintText: 'Link',
                isMultiline: false,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, top: 5),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: getTextStyle(fontSize: 13),
                    children: [
                     TextSpan(text: 'By submitting you agree to our ',
                      style: getTextStyle(fontSize: 13)),
                      TextSpan(text: 'Terms',
                        style:  getTextStyle(decoration: TextDecoration.underline, fontSize: 13),
                      ),
                      TextSpan(text: ', ', style: getTextStyle(fontSize: 13)),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: getTextStyle(decoration: TextDecoration.underline,fontSize: 13),
                      ),
                      TextSpan(text: ', and ',
                       style: getTextStyle(fontSize: 13),
                      ),
                      TextSpan(
                        text: 'Cookie Use',
                        style: getTextStyle(decoration: TextDecoration.underline, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              BlackButton(text: 'Submit', width: double.infinity, height:55,
               onPressed: (){
                 showModalBottomSheet(
                   context: context,
                   isScrollControlled: true,
                   backgroundColor: Colors.transparent,
                   builder: (context) => const DetailsSavedSheet(),);
                    },
                    ),
              const Gap(12),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for shadowed fields matching the target design
  Widget _buildShadowedField({
    required TextEditingController controller,
    required String hintText,
    bool isMultiline = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
         color: AppColors.lightt, width: 2,),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? (isMultiline ? TextInputType.multiline : TextInputType.text),
        maxLines: isMultiline ? 3 : 1,
        style: getTextStyle(fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: getTextStyle(color: AppColors.lighticon, fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}
