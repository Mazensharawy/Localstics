import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';
import 'package:localsticss/features/Seller/accountS/changepass_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Emekus');
  final TextEditingController _emailController = TextEditingController(text: 'emekus@email.com');
  final TextEditingController _phoneController = TextEditingController(text: '+234 800 000 0000');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Settings',
          style: getTextStyle(
            fontSize: 24,fontweight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                const Gap(10),
                Image.asset(
                  'assets/bag.png',
                  width: 48,
                  height: 48,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(3),
              Text(
                'Verified Information',
                style: getTextStyle(
                  fontSize: 18,
                  fontweight: FontWeight.bold,),
              ),
              const Gap(15),
              _buildEditableField('Full Name', _nameController),
              const Gap(18),
              _buildEditableField('Email Address', _emailController),
              const Gap(18),
              _buildEditableField('Phone Number', _phoneController),
              const Gap(32),
              Text('Password',
                style: getTextStyle(
                  fontSize: 18,
                  fontweight: FontWeight.bold,),
              ),
              const Gap(15),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  push(context, const ChangePasswordScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline, size: 20, color: Colors.black54),
                      const Gap(10),
                      Text('Change Password',
                        style: getTextStyle(
                          fontSize: 16,
                          color: AppColors.darkgrey,),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(32),
              BlackButton(text: 'Save Changes', width: double.infinity, height: 50,
               onPressed: (){ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(backgroundColor: AppColors.darkgrey,content: Text('Information saved!', style: getTextStyle(
                        color: AppColors.bgColor
                      ),)),);},),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 15,
            color: AppColors.darkgrey,
            fontweight: FontWeight.w500,),
        ),
        const Gap(8),
        TextFormField(
          controller: controller,
          style: getTextStyle(fontSize: 16,),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.bgColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.lightt),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.lightt),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.lightt),
            ),
          ),
        ),
      ],
    );
  }
}
