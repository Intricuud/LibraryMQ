import 'package:flutter/material.dart';
import 'package:mq_library_app/app_library.dart';
import 'package:mq_library_app/app_screen/app_signup_screen.dart';
import 'package:mq_library_app/auth/firebase_auth.dart';
import 'package:mq_library_app/widget/widget_login_button.dart';
import 'package:mq_library_app/widget/widget_textinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Setup Firebase Authentication
  final _auth = AuthService();

  // Text box input for email and password
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Wrap with Container
        color: Colors.white, // Set background color to white
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Spacer(),
              // Title Login Text
              const Text("Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
              const SizedBox(height: 50),
              // Text box for email
              LoginTextInput(
                hint: "Enter Email",
                label: "Email",
                controller: _email,
              ),
              const SizedBox(height: 20),
              // Text box for password
              LoginTextInput(
                hint: "Enter Password",
                label: "Password",
                isPassword: true,
                controller: _password,
              ),
              const SizedBox(height: 30),
              // Button for Login
              LoginButton(
                label: "Login",
                onPressed: _login,
              ),
              const SizedBox(height: 5),
              // Redirect to Signup Screen
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account yet? "),
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

  // Setup Page route for Sign up Screen
  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  // Setup Page route for Home
  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LibraryMQ()),
      );

  // Login successful will take to home
  _login() async {
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      goToHome(context);
    }
  }
}
