import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 30),
            const Text(
              'حاضرة مليانة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'مدينة العلم والإحياء',
              style: TextStyle(
                color: AppColors.lightBlue,
                fontSize: 20,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 60),
            const CircularProgressIndicator(
              color: AppColors.lightBlue,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
