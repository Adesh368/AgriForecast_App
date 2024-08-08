import 'dart:convert';
import 'package:location_app/reusable_widget/circular_image.dart';
import 'package:location_app/reusable_widget/diagonal_image.dart';
import 'package:location_app/reusable_widget/geometric_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:location_app/reusable_widget/build_bottom_sheet.dart';
import 'package:location_app/reusable_widget/build_page.dart';
import 'package:location_app/screens/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int current = 0;
  bool isLastPageReached = false;
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  Future<void> _save() async {
    var userDatas = json.encode({
      'onboard': 'check',
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('validate', userDatas);
  }

  void _next() {
    _save();
    if (isLastPageReached) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );
    } else {
      _controller?.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _skip() {
    _save();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      current = index;
      if (index == 2) {
        isLastPageReached = true;
      } else {
        isLastPageReached = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _controller,
          onPageChanged: _onPageChanged,
          children: const [
            BuildPage(
              title: 'Welcome to AgriForecast',
              description: 'Get real-time crop forecasts and recommendations.',
              image: CircularPattern(),
            ),
            BuildPage(
              title: 'Explore Features',
              description:
                  'Enter crop and location details to get accurate predictions.',
              image: DiagonalStripe(),
            ),
            BuildPage(
              title: 'Start Forecasting',
              description:
                  'Sign up to get started with personalized forecasts.',
              image: GeometricTriangle(),
            ),
          ]),
      bottomSheet: BuildBottomSheet(
        nextPage: _next,
        skip: _skip,
      ),
    );
  }
}
