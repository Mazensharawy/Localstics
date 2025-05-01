import 'dart:developer';
import 'auth_service.dart';
import 'login_screen.dart';
import 'package:localstics/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  void _validateForm() {
    final emailRegex = RegExp(r"^[^@]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$");
    final passwordRegex = RegExp(r"^[A-Z][a-zA-Z0-9]{5,}$");

    setState(() {
      _isNameValid = _name.text.trim().isNotEmpty;
      _isEmailValid = emailRegex.hasMatch(_email.text.trim());
      _isPasswordValid = passwordRegex.hasMatch(_password.text.trim());

      _isFormValid = _isNameValid && _isEmailValid && _isPasswordValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Password", "Example12", _password, _isPasswordValid,
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
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller, bool isValid,
      {bool isPassword = false, bool isEmail = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),

        // Updates suffix icon in real-time based on validity
        suffixIcon: isValid
            ? Icon(Icons.check_circle, color: Colors.green)
            : Icon(Icons.error, color: Colors.red),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: isValid ? Colors.grey : Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: isValid ? Colors.blue : Colors.red),
        ),
        errorText: !isValid ? "Please enter a valid $label" : null,
      ),
    );
  }

  Widget _buildSocialButton(
      IconData icon, String text, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 10),
            Text(text, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );

  void _validateAndSignup() {
    if (_isFormValid) {
      _signup();
    }
  }

  _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      log("User Created Successfully");
      goToHome(context);
    }
  }
}
