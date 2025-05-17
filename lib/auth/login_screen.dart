import 'dart:developer';
import 'auth_service.dart';
import 'signup_screen.dart';
import 'package:localstics/main.dart';
import 'package:flutter/material.dart';
import 'package:localstics/features/Seller/user_mode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../onboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isFormValid = false;

  bool _emailTouched = false;
  bool _passwordTouched = false;

  String? _loginError;

  @override
  void initState() {
    super.initState();
    _email.addListener(_validateForm);
    _password.addListener(_validateForm);
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void _validateForm() {
    final emailRegex = RegExp(r"^[^@]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$");
    final password = _password.text.trim();
    final passwordValid = password.length >= 10 &&
        RegExp(r"[A-Z]").hasMatch(password) &&
        RegExp(r"[a-z]").hasMatch(password) &&
        RegExp(r"[0-9]").hasMatch(password);
    setState(() {
      _isEmailValid = emailRegex.hasMatch(_email.text.trim());
      _isPasswordValid = passwordValid;
      _isFormValid = _isEmailValid && _isPasswordValid;
    });
  }

  String? _passwordErrorText(String password, bool touched) {
    if (!touched) return null;
    if (password.isEmpty) return "Please enter a valid Password";
    if (password.length < 10) return "Password must be at least 10 characters";
    if (!RegExp(r"[A-Z]").hasMatch(password)) return "Password must have at least 1 uppercase letter";
    if (!RegExp(r"[a-z]").hasMatch(password)) return "Password must have at least 1 lowercase letter";
    if (!RegExp(r"[0-9]").hasMatch(password)) return "Password must have at least 1 number";
    return null;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Login to your account",
                  style: TextStyle(
                    fontFamily: "Aleo",
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.05,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "It’s great to see you again.",
                  style: TextStyle(
                    color: Color(0xFF808080),
                    fontFamily: "Aleo",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),

                if (_loginError != null)
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
                            _loginError!,
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),

                _buildTextField(
                    "Email", "Example@Example.Example", _email, _isEmailValid,
                    isEmail: true),
                const SizedBox(height: 20),

                _buildTextField(
                    "Password", "Example123", _password, _isPasswordValid,
                    isPassword: true),
                const SizedBox(height: 10),
                const Text(
                  "Forgot your password? Reset your password",
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _login, // Always enabled
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                buildSocialButton(
                  icon: FontAwesomeIcons.google,
                  text: "Login with Google",
                  bgColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () async {
                    await _loginWithGoogle();
                  },
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account? "),
                  InkWell(
                    onTap: () => goToSignup(context),
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline, // Underline the text
                      ),
                    ),
                  )
                ]),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSignup() {
    if (_isFormValid) {
      _login();
    }
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller, bool isValid,
      {bool isPassword = false, bool isEmail = false}) {
    void Function()? setTouched;
    if (controller == _email) {
      setTouched = () {
        if (!_emailTouched) setState(() => _emailTouched = true);
      };
    } else if (controller == _password) {
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFF808080)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFF808080), width: 2.0),
        ),
      ),
    );
  }

  Widget buildSocialButton({
    required IconData icon,
    required String text,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    final isGoogle = icon == FontAwesomeIcons.google;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
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
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  goToHome(BuildContext context) => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => UserModeWrapper()),
        (route) => false,
      );

  _login() async {
    setState(() {
      _loginError = null;
    });
    try {
      final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
      if (user != null) {
        log("User Logged In");
        goToHome(context);
      } else {
        setState(() {
          _loginError = "Email or password is incorrect.";
        });
      }
    } catch (e) {
      setState(() {
        _loginError = e is String
            ? e
            : (e is Exception && e.toString().isNotEmpty)
                ? e.toString().replaceFirst('Exception: ', '')
                : "An unexpected error occurred. Please try again.";
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _loginError = null;
    });
    try {
      await GoogleSignIn().signOut();
      final user = await _auth.signInWithGoogle();
      if (user != null) {
        final email = user.email ?? '';
        final existing = await Supabase.instance.client
            .from('users')
            .select('email')
            .eq('email', email)
            .maybeSingle();
        if (existing != null) {
          goToHome(context);
        } else {
          setState(() {
            _loginError = "Please sign up first.";
          });
        }
      } else {
        setState(() {
          _loginError = "Google login failed.";
        });
      }
    } catch (e) {
      setState(() {
        _loginError = e is String
            ? e
            : (e is Exception && e.toString().isNotEmpty)
                ? e.toString().replaceFirst('Exception: ', '')
                : "An unexpected error occurred. Please try again.";
      });
    }
  }
}
