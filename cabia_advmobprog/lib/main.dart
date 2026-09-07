import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cabia_mobile/constants.dart';
import 'package:cabia_mobile/providers/cart_provider.dart';
import 'package:cabia_mobile/providers/theme_provider.dart';
import 'package:cabia_mobile/screens/home_screen.dart';
import 'package:cabia_mobile/screens/profile_screen.dart';
import 'package:cabia_mobile/screens/settings_screens.dart';
import 'package:cabia_mobile/screens/signin_screen.dart';
import 'package:cabia_mobile/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return MaterialApp(
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF3155D9),
              brightness: Brightness.light,
            ).copyWith(
              secondary: const Color(0xFFD94343),
              tertiary: const Color(0xFFE87832),
              surface: const Color(0xFFF2FBFC),
            ),
        scaffoldBackgroundColor: const Color(0xFFEAF7F8),
      ),
      darkTheme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF456BFF),
              brightness: Brightness.dark,
            ).copyWith(
              secondary: const Color(0xFFF05A54),
              tertiary: const Color(0xFFFF8A3D),
              surface: const Color(0xFF132B35),
              surfaceContainer: const Color(0xFF193943),
            ),
        scaffoldBackgroundColor: const Color(0xFF0B1E27),
      ),
      themeMode: themeModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signin': (context) => const SignInScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
