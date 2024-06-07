import 'package:flutter/material.dart';
import 'package:mq_library_app/app_screen/app_login_screen.dart';
import 'package:mq_library_app/auth/firebase_auth.dart';
import 'package:mq_library_app/widget/widget_login_button.dart';
import 'package:mq_library_app/widget/widget_textinput.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Setting authentication for Firebase
  final _auth = AuthService();

  // the text box for name, email and password
  final _name = TextEditingController();
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
              // Sign up Title
              const Text("Signup",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 50,
              ),
              // Text box for Name
              LoginTextInput(
                hint: "Enter Name",
                label: "Name",
                controller: _name,
              ),
              // Text box for Email
              const SizedBox(height: 20),
              LoginTextInput(
                hint: "Enter Email",
                label: "Email",
                controller: _email,
              ),
              // Text box for Password
              const SizedBox(height: 20),
              LoginTextInput(
                hint: "Enter Password",
                label: "Password",
                isPassword: true,
                controller: _password,
              ),
              const SizedBox(height: 30),
              // Button for signup that implement function to signup
              LoginButton(
                label: "Signup",
                onPressed: _signup,
              ),
              const SizedBox(height: 5),
              // User can click to redirect back to login page
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already have an account? "),
                InkWell(
                  onTap: () => goToLogin(context),
                  child:
                      const Text("Login", style: TextStyle(color: Colors.red)),
                )
              ]),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  // Function for routing the page to Login Screen
  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  // function for sign up account for firebase
  _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      goToLogin(context);
    }
  }
}
