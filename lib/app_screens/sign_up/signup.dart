import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets/custom_auth_textformfield.dart';
import '../../reusable_widgets/custom_button.dart';
import '../../utils/app_assets.dart';
import '../login/login.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/SignUp';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  Future<void> signUp() async {
    try {
      final Response response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/register',
        data: {
          "email": emailController.text,
          "password": passwordController.text,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
        },
      );
      log('res is $response');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } on DioException catch (e) {
      log('dio error is ${e.response?.data ?? e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Sign-up failed: ${e.response?.data['message'] ?? 'Something went wrong.'}",
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
        title: const Text('Sign Up'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(AppAssets.signUp, height: 200),
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
              CustomTextFormField(
                hintText: 'First Name',
                controller: firstNameController,
              ),
              CustomTextFormField(
                hintText: 'Last Name',
                controller: lastNameController,
              ),
              const SizedBox(height: 31),
              CustomButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await signUp();
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  }
                },
                BgColor: const Color(0xff1F41BB),
                fontColor: Colors.white70,
                width: 357,
                height: 60,
                text: 'Sign Up',
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Image.network(
                  'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png',
                  height: 24,
                ),
                label: const Text('Sign up with Google'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: 'Login',
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
    );
  }
}
