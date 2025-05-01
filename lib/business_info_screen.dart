import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BusinessInfoScreen extends StatefulWidget {
  const BusinessInfoScreen({super.key});

  @override
  State<BusinessInfoScreen> createState() => _BusinessInfoScreenState();
}

class _BusinessInfoScreenState extends State<BusinessInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _socialMediaLinkController = TextEditingController();

  final String _serifFontFamily = 'Georgia';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    });
  }


  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _phoneNumberController.dispose();
    _socialMediaLinkController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final labelStyle = TextStyle(
      fontFamily: _serifFontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.black87,
    );
    final inputStyle = TextStyle(fontFamily: _serifFontFamily, color: Colors.black);
    final hintStyle = TextStyle(color: Colors.grey[400], fontFamily: _serifFontFamily);
    final borderColor = const Color(0x1F000000);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: inputStyle,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: borderColor, width: 1.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String urlString) async {
    print("Attempting to launch $urlString");
    // TODO: implement actual URL launcher
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.all(30),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_rounded, size: 60, color: Colors.black),
            const SizedBox(height: 20),
            Text(
              "Details Saved",
              style: TextStyle(
                fontFamily: _serifFontFamily,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Your details have been saved successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: _serifFontFamily,
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(
                "Wait for admin approval",
                style: TextStyle(
                  fontFamily: _serifFontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    final titleStyle = textTheme.headlineSmall?.copyWith(
      fontFamily: _serifFontFamily,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ) ??
        TextStyle(
          fontFamily: _serifFontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        );

    final subtitleStyle = textTheme.bodyMedium?.copyWith(
      fontFamily: _serifFontFamily,
      fontSize: 14,
      color: Colors.grey[700],
    ) ??
        TextStyle(
          fontFamily: _serifFontFamily,
          fontSize: 14,
          color: Colors.grey[700],
        );

    final footerStyle = textTheme.bodySmall?.copyWith(
      fontFamily: _serifFontFamily,
      fontSize: 12,
      color: Colors.grey[700],
    ) ??
        TextStyle(
          fontFamily: _serifFontFamily,
          fontSize: 12,
          color: Colors.grey[700],
        );

    final linkStyle = footerStyle.copyWith(
      decoration: TextDecoration.underline,
      color: Colors.black,
      decorationColor: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 111,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12.0)),
            gradient: const LinearGradient(
              colors: [Color(0xFFF5F5F5), Color(0xFFE8E8E8)],
              begin: Alignment(-1.0, -0.2),
              end: Alignment(1.0, 0.2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Business Information', style: titleStyle),
                const SizedBox(height: 4),
                Text('Provide your business details', style: subtitleStyle),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 10.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset('images/appbar_logo_black.png', width: 60, fit: BoxFit.cover),
            ),
          ),
        ],
        title: null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.grey[700], size: 40),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  _buildTextField(
                    controller: _storeNameController,
                    label: 'Store Name',
                    hintText: 'Your Store Name',
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hintText: 'Describe your business...',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _phoneNumberController,
                    label: 'Phone Number',
                    hintText: 'Official Phone Number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _socialMediaLinkController,
                    label: 'Social Media Link',
                    hintText: 'Link',
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: footerStyle,
                        children: [
                          const TextSpan(text: 'By submitting you agree to our '),
                          TextSpan(
                            text: 'Terms',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl('https://example.com/terms'),
                          ),
                          const TextSpan(text: ', '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl('https://example.com/privacy'),
                          ),
                          const TextSpan(text: ', and '),
                          TextSpan(
                            text: 'Cookie Use',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _launchUrl('https://example.com/cookies'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      textStyle: TextStyle(
                        fontFamily: _serifFontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        print('Store Name: ${_storeNameController.text}');
                        print('Description: ${_descriptionController.text}');
                        print('Phone Number: ${_phoneNumberController.text}');
                        print('Social Link: ${_socialMediaLinkController.text}');
                        _showSuccessDialog();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
