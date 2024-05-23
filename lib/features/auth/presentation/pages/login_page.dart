import 'package:budgetmate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:budgetmate/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:budgetmate/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthRemoteDataSource();

  bool isLoading = false;

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                const Text(
                  'SIGN IN TO YOUR ACCOUNT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 70),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _password,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                          obscureText: true,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 25),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPage()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: "Gruppo-Regular"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 47, 125, 121), // Set transparent color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: "Gruppo-Regular"),
                  ),
                ),
                const SizedBox(height: 50),
                isLoading
                    ? const CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _auth.loginWithGoogle();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : Image.asset(
                                  'assets/images/google_logo...webp',
                                  width: 38,
                                  height: 38,
                                ),
                        ),
                      ),
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () => goToSignup(context),
                    child: const Text(
                      'Do you need an Account? Register',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Gruppo-Regular"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const SignupScreen()),
      );

  _login() async {
    await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
  }
}
