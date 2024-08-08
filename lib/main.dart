import 'package:flutter/material.dart';
import 'package:location_app/state/input_provider.dart';
import 'package:location_app/state/map_screen.dart';
import 'package:location_app/state/sign_in_provider.dart';
import 'package:location_app/state/sign_up_provider.dart';
import 'package:provider/provider.dart';
import 'package:location_app/screens/splash.dart';
import 'package:location_app/state/splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => SignUpProvider(),
        ),
         ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => SignInProvider(),
        ),
        ChangeNotifierProvider(
          //return ChangeNotifierProvider.value(
          create: (ctx) => SplashScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => MapProvider(),
          ),
           ChangeNotifierProvider(
          create: (ctx) => InputProvider(),
          )
      ],
      child: Consumer<SplashScreenProvider>(
        builder: (ctx, splashscreenProvider, _) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    ),
  );
}
