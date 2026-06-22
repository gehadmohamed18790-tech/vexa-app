import 'package:flutter/material.dart';
import 'package:mywalletapp/core/constants/app_colors.dart';
import 'package:mywalletapp/core/storage/cach_helper.dart';
import 'package:mywalletapp/features/auth/presentation/login_screen.dart';
//import 'package:mywalletapp/features/auth/presentation/login_screen.dart';
//import 'package:mywalletapp/features/home/presentation/home_screen.dart';
import 'package:mywalletapp/features/home/presentation/main_tabs_screen.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (CacheHelper.getData(key: "user") != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainTabsScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientStartColor,
              AppColors.gradientEndColor,
            ],
          ),
        ),
        child: const Center(
          child: Image(
            image: AssetImage('assets/route_logo.png'), 
            width: 250,
          ),
        ),
      ),
    );
  }
}
