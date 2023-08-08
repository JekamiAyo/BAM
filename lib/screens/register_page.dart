import 'package:bam/services/auth/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // bool _isLoading = false;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final authService = AuthService();

  register() async {
    if (formkey.currentState!.validate()) {
      // setState(() {
      //   _isLoading = true;
      // });
      try {
        await authService.registerUserWithEmailandPassword(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //  _isLoading
          //     ? Center(
          //         child: CircularProgressIndicator(
          //           color: Theme.of(context).primaryColor,
          //         ),
          //       )
          //     :
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: formkey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "BAM",
                    style: GoogleFonts.acme(fontSize: 40),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create your account now and explore!",
                    style: GoogleFonts.acme(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset('lib/assets/the boys.jpg'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: Constants.textInputDecoration.copyWith(
                      hintText: "Full Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      return (val!.isNotEmpty)
                          ? null
                          : "Please enter your name";
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: Constants.textInputDecoration.copyWith(
                      hintText: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                          ? null
                          : "Please enter valid email";
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: Constants.textInputDecoration.copyWith(
                      hintText: "Password",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      return (val!.length < 6)
                          ? "password must be at least 6 characters"
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.acme(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text.rich(
                    TextSpan(
                        text: "Already have an account?",
                        style: GoogleFonts.acme(fontSize: 14),
                        children: [
                          TextSpan(
                            text: " Sign up here",
                            style: GoogleFonts.acme(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onTap,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
