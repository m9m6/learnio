import 'package:flutter/material.dart';

import '../../reusable_widgets/custom_auth_textformfield.dart';
import '../../utils/app_assets.dart';
import '../sign_up/signup.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/Login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset(AppAssets.login, height: 200),
            const SizedBox(height: 40),
            AuthTextFormField(label: 'Email', controller: emailController),
            AuthTextFormField(
              label: 'Password',
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/4/4e/Google_%22G%22_Logo.svg',
                height: 24,
              ),
              label: const Text('Sign in with Google'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text.rich(
                TextSpan(
                  text: "Don’t have an account? ",
                  style: TextStyle(color: Colors.black87),
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
