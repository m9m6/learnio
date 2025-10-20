import 'package:flutter/material.dart';
import 'package:learnio/app_screens/login/login.dart';
import 'package:learnio/app_screens/sign_up/signup.dart';

import '../../reusable_widgets/custom_elevated_button.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/OnboardingScreen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  //Go to Next
  void _goToNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  //BottomSheet
  Widget _buildBottomSheet({
    required String title,
    required String description,
    required VoidCallback onNext,
    required VoidCallback onSkip,
    bool isLast = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.black87, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: onSkip,
                  text: 'Skip',
                  backgroundColor: Colors.white,
                  textColor: const Color(0xff5F61F0),
                  borderColor: const Color(0xff5F61F0),
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: onNext,
                  text: isLast ? 'Finish' : 'Next',
                  backgroundColor: const Color(0xff5F61F0),
                  textColor: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Onboarding Page
  Widget _buildPage({
    required Color bgColor,
    required String imageAsset,
    required String title,
    required String description,
    bool isLast = false,
  }) {
    return Container(
      color: bgColor,
      child: Column(
        children: [
          const SizedBox(height: 80),
          Expanded(
            child: SizedBox(
              height: 215,
              width: 350,
              child: Image.asset(imageAsset, fit: BoxFit.contain),
            ),
          ),
          _buildBottomSheet(
            title: title,
            description: description,
            onNext: _goToNext,
            onSkip: _goToNext,
            isLast: isLast,
          ),
        ],
      ),
    );
  }

  // Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: [
          _buildPage(
            bgColor: AppColors.firstOnBoardingColor,
            imageAsset: AppAssets.onB1,
            title: 'Explore Courses',
            description:
                'Browse a wide range of learning programs designed to boost your skills in tech, business, and more!',
          ),
          _buildPage(
            bgColor: AppColors.secondOnBoardingColor,
            imageAsset: AppAssets.onB2,
            title: 'Track Your Progress',
            description:
                'Follow your learning journey step by step, complete lessons, and earn achievements along the way.',
          ),
          _buildPage(
            bgColor: AppColors.the3rdOnBoardingColor,
            imageAsset: AppAssets.onB3,
            title: 'Start Learning Today',
            description:
                'Sign in now and unlock access to expert-led courses that help you grow your career and knowledge!',
            isLast: true,
          ),
        ],
      ),
    );
  }
}
