import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';
import 'login_screen.dart';
import 'package:localstics/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localstics/features/Seller/user_mode.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../onboard.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isFormValid = false;

  // Track if user has interacted with each field
  bool _nameTouched = false;
  bool _emailTouched = false;
  bool _passwordTouched = false;

  String? _signupError;
  bool _facebookBanner = false;

  @override
  void initState() {
    super.initState();
    _name.addListener(_validateForm);
    _email.addListener(_validateForm);
    _password.addListener(_validateForm);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  String? _passwordErrorText(String password, bool touched) {
    if (!touched) return null;
    if (password.isEmpty) return "Please enter a valid Password (Ex: Example123)";
    if (password.length < 10) return "Password must be at least 10 characters";
    if (!RegExp(r"[A-Z]").hasMatch(password)) return "Password must have at least 1 uppercase letter";
    if (!RegExp(r"[a-z]").hasMatch(password)) return "Password must have at least 1 lowercase letter";
    if (!RegExp(r"[0-9]").hasMatch(password)) return "Password must have at least 1 number";
    return null;
  }

  void _validateForm() {
    final emailRegex = RegExp(r"^[^@]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$");
    final password = _password.text.trim();
    final passwordValid = password.length >= 10 &&
        RegExp(r"[A-Z]").hasMatch(password) &&
        RegExp(r"[a-z]").hasMatch(password) &&
        RegExp(r"[0-9]").hasMatch(password);
    setState(() {
      _isNameValid = _name.text.trim().isNotEmpty;
      _isEmailValid = emailRegex.hasMatch(_email.text.trim());
      _isPasswordValid = passwordValid;
      _isFormValid = _isNameValid && _isEmailValid && _isPasswordValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Image.asset('images/appbar_logo_black.png',
                width: 60, fit: BoxFit.cover)
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_signupError != null)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _signupError!,
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const Text(
                    "Create an account",
                    style: TextStyle(
                      fontFamily: "Aleo",
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.05,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Let’s create your account.",
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontFamily: "Aleo",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                      "Full Name", "Enter your full name", _name, _isNameValid),
                  const SizedBox(height: 20),
                  _buildTextField(
                      "Email", "Example@Example.Example", _email, _isEmailValid,
                      isEmail: true),
                  const SizedBox(height: 20),
                  _buildTextField(
                      "Password", "Example123", _password, _isPasswordValid,
                      isPassword: true),
                  const SizedBox(height: 10),
                  const Text(
                    "By signing up you agree to our Terms, Privacy Policy, and Cookie Use",
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isFormValid ? _validateAndSignup : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isFormValid ? Colors.black : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Create an Account",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text("OR"),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSocialButton(FontAwesomeIcons.google,
                      "Sign Up with Google", Colors.white, Colors.black),
                  const SizedBox(height: 10),
                  _buildSocialButton(FontAwesomeIcons.facebook,
                      "Sign Up with Facebook", Color(0xFF1877F2), Colors.white),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () => goToLogin(context),
                          child: const Text.rich(
                            TextSpan(
                              text: "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color:
                                    Colors.black, // Color of the underlined text
                                decoration: TextDecoration
                                    .underline, // Underline the text
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller, bool isValid,
      {bool isPassword = false, bool isEmail = false}) {
    bool touched = false;
    void Function()? setTouched;
    if (controller == _name) {
      touched = _nameTouched;
      setTouched = () {
        if (!_nameTouched) setState(() => _nameTouched = true);
      };
    } else if (controller == _email) {
      touched = _emailTouched;
      setTouched = () {
        if (!_emailTouched) setState(() => _emailTouched = true);
      };
    } else if (controller == _password) {
      touched = _passwordTouched;
      setTouched = () {
        if (!_passwordTouched) setState(() => _passwordTouched = true);
      };
    }
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      onChanged: (_) => setTouched?.call(),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        // Show nothing at first, then show indicator after user types
        suffixIcon: !touched
            ? null
            : (isValid
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.error, color: Colors.red)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: !touched
                ? Color(0xFF808080)
                : (isValid ? Colors.green : Colors.red),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: !touched
                ? Color(0xFF808080)
                : (isValid ? Colors.green : Colors.red),
            width: 2.0,
          ),
        ),
        errorText: isPassword
            ? _passwordErrorText(controller.text.trim(), touched)
            : (!isValid && touched ? "Please enter a valid $label" : null),
      ),
    );
  }

  Widget _buildSocialButton(
      IconData icon, String text, Color bgColor, Color textColor) {
    final isFacebook = icon == FontAwesomeIcons.facebook;
    final isGoogle = icon == FontAwesomeIcons.google;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              if (isGoogle) {
                await _signUpWithGoogle();
              } else if (isFacebook) {
                setState(() {
                  _signupError = null;
                });
                setState(() {
                  _facebookBanner = true;
                });
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) setState(() => _facebookBanner = false);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isFacebook ? bgColor.withOpacity(1) : bgColor,
              disabledBackgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isGoogle)
                  Image.asset(
                    'assets/google.png',
                    width: 36,
                    height: 36,
                  )
                else
                  Icon(icon, color: textColor),
                const SizedBox(width: 10),
                Text(text, style: TextStyle(color: textColor)),
              ],
            ),
          ),
        ),
        if (isFacebook && _facebookBanner == true)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Sign up with Facebook will be available in the next update.',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => UserModeWrapper()),
        (route) => false,
      );

  void _validateAndSignup() {
    if (_isFormValid) {
      _signup();
    }
  }

  _signup() async {
    setState(() {
      _signupError = null;
    });
    try {
      // Check if the email is already in use in Firebase
      final signInMethods = await _auth.fetchSignInMethodsForEmail(_email.text.trim());
      if (signInMethods.isNotEmpty) {
        setState(() {
          _signupError = "Email address is already Found. Please Logn.";
        });
        return;
      }

      // Create the user in Firebase
      final userCredential = await _auth.createUserWithEmailAndPassword(
        _email.text.trim(),
        _password.text.trim(),
      );

      // If Firebase user creation is successful, insert the user into the database
      if (userCredential != null) {
        await Supabase.instance.client
            .from('users')
            .insert({
              'username': _name.text.trim(),
              'email': _email.text.trim(),
              'password': _password.text.trim(),
            });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User successfully created!")),
        );
        goToHome(context); // Navigate to the home screen
      }
    } catch (e) {
      setState(() {
        _signupError = e is String
            ? e
            : (e is Exception && e.toString().isNotEmpty)
                ? e.toString().replaceFirst('Exception: ', '')
                : "An unexpected error occurred. Please try again.";
      });
    }
  }

  Future<void> _signUpWithGoogle() async {
    setState(() {
      _signupError = null;
    });
    try {
      await GoogleSignIn().signOut();
      final user = await _auth.signInWithGoogle();
      if (user != null) {
        final name = user.displayName ?? user.email?.split('@').first ?? 'User';
        final email = user.email ?? '';
        // Check if email exists in Supabase
        final existing = await Supabase.instance.client
            .from('users')
            .select('email')
            .eq('email', email)
            .maybeSingle();
        if (existing == null) {
          await Supabase.instance.client
              .from('users')
              .insert({
                'username': name.trim(),
                'email': email,
                'password': '', // No password for Google sign-in
              });
        }
        goToHome(context);
      } else {
        setState(() {
          _signupError = "Google sign-in failed.";
        });
      }
    } catch (e) {
      setState(() {
        _signupError = e is String
            ? e
            : (e is Exception && e.toString().isNotEmpty)
                ? e.toString().replaceFirst('Exception: ', '')
                : "An unexpected error occurred. Please try again.";
      });
    }
  }

  Future<String?> _showInputDialog(BuildContext context, String label, {bool isPassword = false}) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter $label'),
          content: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(labelText: label),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Future<void> _signUpWithFacebook() async {
  //   final user = await _auth.signInWithFacebook();
  //   if (user != null) {
  //     goToHome(context);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Facebook sign-in failed.")),
  //     );
  //   }
  // }
}