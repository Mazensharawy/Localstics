import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/widgets/black_button.dart';
import 'package:localstics/features/Seller/SellerSignUp/details_saved_seller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  File? _selectedImage;
  bool _isLoading = false;
  Widget? _bannerWidget;
  String? _imageFileName;
  // Country code picker for phone input with flags
  final List<Map<String, String>> _countryCodes = [
    {'code': '+20', 'flag': '🇪🇬', 'name': 'Egypt'},
    {'code': '+1', 'flag': '🇺🇸', 'name': 'USA'},
    {'code': '+44', 'flag': '🇬🇧', 'name': 'UK'},
    {'code': '+91', 'flag': '🇮🇳', 'name': 'India'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'UAE'},
    {'code': '+49', 'flag': '🇩🇪', 'name': 'Germany'},
    {'code': '+33', 'flag': '🇫🇷', 'name': 'France'},
  ];
  String _selectedCountryCode = '+20';

  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.white, // Set status bar background to white
  //     statusBarIconBrightness: Brightness.dark, // For dark icons
  //   ));
  // }

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _socialMediaController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser;
  }

  void _showCustomBanner(String message, {Color? color, Color? borderColor, IconData? icon, Color? textColor}) {
    setState(() {
      _bannerWidget = Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12, top: 10),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: (color ?? Colors.red).withOpacity(0.1),
          border: Border.all(color: borderColor ?? (color ?? Colors.red)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon ?? Icons.error_outline, color: (color ?? Colors.red).withOpacity(1)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor ?? color ?? Colors.red, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        _showCustomBanner(
          'No image selected.',
          color: Colors.yellow.shade700,
          borderColor: Colors.yellow.shade700,
          icon: Icons.warning_amber_rounded,
          textColor: Colors.yellow.shade700,
        );
        return;
      }
      final file = File(pickedFile.path);
      final fileSize = await file.length();
      if (fileSize > 5 * 1024 * 1024) { // 5MB limit
        _showCustomBanner(
          'Image too large. Please select an image under 5MB.',
          color: Colors.red.withOpacity(0.1),
          borderColor: Colors.red,
          icon: Icons.error_outline,
          textColor: Colors.red,
        );
        return;
      }
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];
      final ext = pickedFile.name.split('.').last.toLowerCase();
      if (!allowedExtensions.contains(ext)) {
        _showCustomBanner(
          'Unsupported file type. Please select a JPG, PNG, or WEBP image.',
          color: Colors.red.withOpacity(0.1),
          borderColor: Colors.red,
          icon: Icons.error_outline,
          textColor: Colors.red,
        );
        return;
      }
      setState(() {
        _selectedImage = file;
        // Sanitize file name: remove illegal/hidden chars
        _imageFileName = pickedFile.name.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
      });
    } catch (e) {
      _showCustomBanner(
        'Failed to pick image: ${e.toString()}',
        color: Colors.red.withOpacity(0.1),
        borderColor: Colors.red,
        icon: Icons.error_outline,
        textColor: Colors.red,
      );
    }
  }

  Future<String?> _uploadImageToSupabase(File image) async {
    try {
      // Sanitize file name again for safety
      final safeFileName = (_imageFileName ?? image.path.split('/').last).replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
      final fileName = 'seller_${DateTime.now().millisecondsSinceEpoch}_$safeFileName';
      final storage = Supabase.instance.client.storage.from('seller-images');
      final res = await storage.upload(fileName, image);
      if (res.isEmpty) {
        _showCustomBanner(
          'Image upload failed. Please try again.',
          color: Colors.red.withOpacity(0.1),
          borderColor: Colors.red,
          icon: Icons.error_outline,
          textColor: Colors.red,
        );
        return null;
      }
      final publicUrl = storage.getPublicUrl(fileName);
      // Save the file name for DB insert
      setState(() { _imageFileName = fileName; });
      return publicUrl;
    } on StorageException catch (e) {
      String msg = 'Image upload error: ';
      if (e.statusCode == 409) {
        msg += 'A file with this name already exists.';
      } else if (e.statusCode == 413) {
        msg += 'File too large.';
      } else if (e.statusCode == 403) {
        msg += 'Permission denied.';
      } else if (e.statusCode == 404) {
        msg += 'Storage bucket not found.';
      } else {
        msg += e.message;
      }
      _showCustomBanner(
        msg,
        color: Colors.red.withOpacity(0.1),
        borderColor: Colors.red,
        icon: Icons.error_outline,
        textColor: Colors.red,
      );
      return null;
    } catch (e) {
      _showCustomBanner(
        'Unexpected error during image upload: ${e.toString()}',
        color: Colors.red.withOpacity(0.1),
        borderColor: Colors.red,
        icon: Icons.error_outline,
        textColor: Colors.red,
      );
      return null;
    }
  }

  Future<void> _submit() async {
    // Validation
    if (_storeNameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _socialMediaController.text.isEmpty ||
        _selectedImage == null) {
      _showCustomBanner(
        'Please fill all fields and select an image.',
        color: Colors.yellow.shade700,
        borderColor: Colors.yellow.shade700,
        icon: Icons.warning_amber_rounded,
        textColor: Colors.yellow.shade700,
      );
      return;
    }
    // Phone validation
    final phone = _phoneController.text.trim();
    if (!RegExp(r'^[0-9]{7,15}$').hasMatch(phone)) {
      _showCustomBanner(
        'Enter a valid phone number (7-15 digits).',
        color: Colors.red.withOpacity(0.1),
        borderColor: Colors.red,
        icon: Icons.error_outline,
        textColor: Colors.red,
      );
      return;
    }
    setState(() { _isLoading = true; });
    String? imageUrl;
    try {
      imageUrl = await _uploadImageToSupabase(_selectedImage!);
      if (imageUrl == null) {
        setState(() { _isLoading = false; });
        return;
      }
    } catch (e) {
      _showCustomBanner(
        'Unexpected error during image upload: ${e.toString()}',
        color: Colors.red.withOpacity(0.1),
        borderColor: Colors.red,
        icon: Icons.error_outline,
        textColor: Colors.red,
      );
      setState(() { _isLoading = false; });
      return;
    }
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showCustomBanner(
          'User not authenticated.',
          color: Colors.red.withOpacity(0.1),
          borderColor: Colors.red,
          icon: Icons.error_outline,
          textColor: Colors.red,
        );
        setState(() { _isLoading = false; });
        return;
      }
      // Look up the user in Supabase users table by email
      final userEmail = user.email;
      if (userEmail == null) {
        _showCustomBanner(
          'User email not found.',
          color: Colors.red.withOpacity(0.1),
          borderColor: Colors.red,
          icon: Icons.error_outline,
          textColor: Colors.red,
        );
        setState(() { _isLoading = false; });
        return;
      }
      final userRes = await Supabase.instance.client
          .from('users')
          .select('id')
          .eq('email', userEmail)
          .maybeSingle();
      if (userRes == null || userRes['id'] == null) {
        _showCustomBanner(
          'User not found in database.',
          color: Colors.red.withOpacity(0.1),
          borderColor: Colors.red,
          icon: Icons.error_outline,
          textColor: Colors.red,
        );
        setState(() { _isLoading = false; });
        return;
      }
      final supabaseUserId = userRes['id'];
      await Supabase.instance.client.from('seller').insert({
        'user_id': supabaseUserId, // Use Supabase user id as foreign key
        'store_name': _storeNameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'phone_number': _selectedCountryCode + phone,
        'social_link': _socialMediaController.text.trim(),
        'pic': _imageFileName ?? '',
      });
      setState(() {
        _isLoading = false;
        _selectedImage = null;
      });
      if (mounted) {
        Navigator.of(context).pop(true); // This will return to account_screen
      }
    } on PostgrestException catch (e) {
      String msg = 'Database error: ';
      if (e.code == '23505') {
        msg += 'Duplicate entry. This store may already exist.';
      } else if (e.code == '42501') {
        msg += 'Permission denied.';
      } else if (e.code == '23514') {
        msg += 'Invalid data format.';
      } else {
        msg += e.message;
      }
      _showCustomBanner(
        msg,
        color: Colors.red.withOpacity(0.1),
        borderColor: Colors.red,
        icon: Icons.error_outline,
        textColor: Colors.red,
      );
      setState(() { _isLoading = false; });
    } catch (e) {
      _showCustomBanner(
        'Unknown error: ${e.toString()}',
        color: Colors.red.withOpacity(0.1),
        borderColor: Colors.red,
        icon: Icons.error_outline,
        textColor: Colors.red,
      );
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Do not call Navigator.pop here! This causes navigation lock errors.
        // Only perform side effects if needed.
      },
      child: Scaffold(
        backgroundColor: Colors.white, // Chrome OS color and overall background set to white
        // Removed AppBar
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white, // Card color white
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Business Information',
                                    style: getTextStyle(
                                      fontweight: FontWeight.bold, fontSize: 22,
                                    ),),
                                  const SizedBox(height: 4),
                                  Text('Provide your business details',
                                    style: getTextStyle(
                                      fontSize: 14, color: Colors.grey.shade600,
                                    ),),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/bag.png',
                              width: 48,
                              height: 48,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(18),
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.lightt, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.07),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 44,
                              backgroundColor: Colors.grey.shade100,
                              backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                              child: _selectedImage != null
                                  ? null
                                  : Icon(Icons.camera_alt, color: Colors.grey.shade500, size: 36),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(18),
                    Text('Store Name', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
                    const Gap(2),
                    _buildShadowedField(
                      controller: _storeNameController,
                      hintText: 'Your Store Name',
                      isMultiline: false,
                    ),
                    const Gap(16),
                    Text('Description', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
                    const Gap(2),
                    _buildShadowedField(
                      controller: _descriptionController,
                      hintText: 'Describe your business...',
                      isMultiline: true,
                    ),
                    const Gap(16),
                    Text('Phone Number', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
                    const Gap(2),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.lightt, width: 2),
                            color: Colors.white, // Force white background for code picker
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: DropdownButtonHideUnderline(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Colors.white, // Dropdown menu background
                              ),
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                items: _countryCodes.map((country) => DropdownMenuItem(
                                  value: country['code'],
                                  child: Row(
                                    children: [
                                      Text(country['flag']!, style: const TextStyle(fontSize: 18)),
                                      const SizedBox(width: 4),
                                      Text(country['code']!, style: getTextStyle(fontSize: 15)),
                                    ],
                                  ),
                                )).toList(),
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedCountryCode = val);
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildShadowedField(
                            controller: _phoneController,
                            hintText: 'Official Phone Number',
                            isMultiline: false,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    Text('Social Media Link', style: getTextStyle(fontSize: 17, fontweight: FontWeight.bold)),
                    const Gap(2),
                    _buildShadowedField(
                      controller: _socialMediaController,
                      hintText: 'Link',
                      isMultiline: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, top: 10),
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
                    const Gap(18),
                    if (_bannerWidget != null) ...[
                      _bannerWidget!,
                      const Gap(6),
                    ],
                    BlackButton(
                      text: 'Submit',
                      width: double.infinity,
                      height: 55,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.05), // More transparent background
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              ),
          ],
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
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white, // Ensure input background is white
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.lightt, width: 1.5,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? (isMultiline ? TextInputType.multiline : TextInputType.text),
        maxLines: isMultiline ? 3 : 1,
        style: getTextStyle(fontSize: 16, fontweight: FontWeight.w500),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: getTextStyle(color: AppColors.lighticon, fontSize: 16, fontweight: FontWeight.w400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.black, width: 2), // Use black as primary
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        ),
      ),
    );
  }
}

// In details_saved_seller.dart, after showing the details saved sheet, poll the database for approval status
// Add a function to poll the seller's approval status and navigate to SellerMainScreen when approved
// This code assumes you have a SellerMainScreen widget for the seller main page

// In details_saved_seller.dart (DetailsSavedSheet), add:
//
// @override
// void initState() {
//   super.initState();
//   _startApprovalPolling();
// }
//
// void _startApprovalPolling() async {
//   final userId = ...; // get current seller/user id
//   while (mounted) {
//     final res = await Supabase.instance.client
//         .from('seller')
//         .select('approved')
//         .eq('user_id', userId)
//         .maybeSingle();
//     if (res != null && res['approved'] == true) {
//       if (!mounted) return;
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => SellerMainScreen()),
//         (route) => false,
//       );
//       break;
//     }
//     await Future.delayed(const Duration(seconds: 3));
//   }
// }
//
// The DetailsSavedSheet UI remains visible until approval is true in the database.
//
// Make sure to pass the seller/user id to DetailsSavedSheet if needed.
//
// This will keep the user on the waiting screen until admin approval, then send them to the seller main page.
