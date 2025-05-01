import 'dart:developer';
import 'auth_service.dart';
import 'signup_screen.dart';
import 'package:localstics/main.dart';
import 'package:flutter/material.dart';
import 'package:localstics/features/Seller/user_mode.dart';

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
    final passwordRegex = RegExp(r"^[A-Z][a-zA-Z0-9]{5,}$");

    setState(() {
      _isEmailValid = emailRegex.hasMatch(_email.text.trim());
      _isPasswordValid = passwordRegex.hasMatch(_password.text.trim());

      _isFormValid = _isEmailValid && _isPasswordValid;
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

              _buildTextField(
                  "Email", "Example@Example.Example", _email, _isEmailValid,
                  isEmail: true),
              const SizedBox(height: 20),


              // TextField(
              //   obscureText: false,
              //   controller: _email,
              //   decoration: InputDecoration(
              //       hintText: "Enter Email",
              //       contentPadding:
              //       const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              //       label: Text("Email"),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(6),
              //           borderSide: const BorderSide(color: Colors.grey, width: 1))),
              // ),

              _buildTextField(
                  "Password", "Example12", _password, _isPasswordValid,
                  isPassword: true),
              // TextField(
              //   obscureText: false,
              //   controller: _password,
              //   decoration: InputDecoration(
              //       hintText: "Enter Password",
              //       contentPadding:
              //       const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              //       label: Text("Password"),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(6),
              //           borderSide: const BorderSide(color: Colors.grey, width: 1))),
              // ),
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
                  onPressed: _isFormValid ? _validateAndSignup : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isFormValid ? Colors.black : Colors.grey,
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

              SizedBox(
                  width: 180,
                  height: 42,
                  child: ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        "Login",
                        style: const TextStyle(fontSize: 18),
                      ))),

              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already have an account? "),
                InkWell(
                  onTap: () => goToSignup(context),
                  child:
                      const Text("Signup", style: TextStyle(color: Colors.red)),
                )
              ]),
              const Spacer()
            ],
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

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserModeWrapper()),
      );

  _login() async {
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log("User Logged In");
      goToHome(context);
    }
  }
}
