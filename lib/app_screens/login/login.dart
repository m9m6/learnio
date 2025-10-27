import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/custom_auth_textformfield.dart';
import '../../reusable_widgets/custom_button.dart';
import '../../utils/app_assets.dart';
import '../home_screen.dart';
import '../sign_up/signup.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/Login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> logIn() async {
    try {
      final Response response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/login',
        data: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );
      log('res is $response');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        ),
      );
    } on DioException catch (e) {
      log('dio error is ${e.response?.data ?? e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login failed: ${e.response?.data['message'] ?? 'Invalid credentials.'}",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    } catch (e) {
      log('dio exception $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unexpected error occurred."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(AppAssets.login, height: 200),
                const SizedBox(height: 40),
                CustomTextFormField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                CustomTextFormField(
                  hintText: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 31),
                CustomButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await logIn();
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    }
                  },
                  BgColor: const Color(0xff1F41BB),
                  fontColor: Colors.white70,
                  width: 357,
                  height: 60,
                  text: 'Sign in',
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.network(
                    'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png',
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
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
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
        ),
      ),
    );
  }
}
