import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';
import 'package:localsticss/features/Seller/accountS/pass_reset_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Settings',
          style: getTextStyle(
            fontSize: 24, fontweight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child:Image.asset('assets/bag.png',width: 48,height: 48,
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change Password',
              style: getTextStyle(
                fontSize: 20,
                fontweight: FontWeight.bold,),
            ),
            Text('Enter your new password',
              style: getTextStyle(
                fontSize: 15,
                color: AppColors.darkgrey,),
            ),
            const Gap(20),
            _buildPasswordField('Current Password', _currentPasswordController, _showCurrentPassword, () {
              setState(() {
                _showCurrentPassword = !_showCurrentPassword;
              });
            }),
            const Gap(12),
            _buildPasswordField('New Password', _newPasswordController, _showNewPassword, () {
              setState(() {
                _showNewPassword = !_showNewPassword;
              });
            }),
            const Gap(32),
            BlackButton(text: 'Change Password', width: double.infinity, height: 50,
             onPressed: () {
               pushWithReplacement(context, const PasswordResetSuccessScreen());
             },),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool show, VoidCallback onToggle) {
    return TextFormField(
      controller: controller,
      obscureText: !show,
      style: getTextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: getTextStyle(color: AppColors.darkgrey, fontSize: 16),
        filled: true,
        fillColor: AppColors.bgColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.lightt),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.lightt),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.lightt),
        ),
        suffixIcon: IconButton(
          icon: Icon(show ? Icons.visibility : Icons.visibility_off, color: Colors.black54, size: 18),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
