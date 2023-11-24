import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/SplashScreen/splash_screen.dart';
import 'SharedPrefrences/sharedprefrences.dart';

late SharedPreferences _sharedPreferences;

bool? isFirstTime = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  await _initializePrefs();
  runApp(MyApp());
}

Future<void> _initializePrefs() async {
  print('--------');
  _sharedPreferences = await SharedPreferences.getInstance();
  isFirstTime = SharedPreferencesHelper.getFirstTime();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the custom primary swatch color
    MaterialColor customPrimarySwatch = const MaterialColor(
      0xFF4fedb4,
      <int, Color>{
        50: const Color(0xFF4fedb4),
        100: const Color(0xFF4fedb4),
        200: const Color(0xFF4fedb4),
        300: const Color(0xFF4fedb4),
        400: const Color(0xFF4fedb4),
        500: const Color(0xFF4fedb4),
        600: const Color(0xFF4fedb4),
        700: const Color(0xFF4fedb4),
        800: const Color(0xFF4fedb4),
        900: const Color(0xFF4fedb4),
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickCart',
      theme: ThemeData(
        primarySwatch: customPrimarySwatch,
      ),
      home: SplashScreen(),
    );
  }
}
