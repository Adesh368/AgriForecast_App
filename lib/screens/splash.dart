import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_app/reusable_widget/logo.dart';

import 'package:location_app/screens/onboarding.dart';
import 'package:location_app/screens/sign_in.dart';
import 'package:location_app/screens/welcome_screen.dart';
import 'package:location_app/state/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String? userEmail;
  String? onboardData;

  

  // Get Saved Data Method
  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    var extracteduserdata =
        json.decode(prefs.getString('useremail').toString());
    var validateOnboardingScreen =
        json.decode(prefs.getString('validate').toString());

    if (extracteduserdata != null) {
      setState(() {
        userEmail = extracteduserdata['email'];
      });
    }
    if (validateOnboardingScreen != null) {
      setState(() {
        onboardData = validateOnboardingScreen['onboard'];
      });
    }
  }

  @override
  void initState() {
    Provider.of<SplashScreenProvider>(context, listen: false)
        .getCurrentLocation();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _getData().whenComplete(() async {
       Timer(const Duration(seconds: 5), () {
        if (userEmail == null || onboardData == null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const OnboardingScreen();
          }));
        }
        if (onboardData != null && userEmail != null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const WelcomeScreen();
          }));
        }
        if (onboardData != null && userEmail == null) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (ctx) {
            return const SignInScreen();
          }));
        }
    });
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Logo()),
    );
  }
}
