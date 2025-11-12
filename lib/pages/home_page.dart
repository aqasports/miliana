import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // MainNavigation already provides Directionality, Scaffold and AppBar.
    // Pages should provide content only so they render inside the main layout.
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Text(
            'مرحبًا بكم في حاضرة مليانة',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'مدينة العلم والإحياء، حيث نعيد المجد لعلوم الشريعة والعقل واللغة.',
            style: TextStyle(
              fontSize: 18,
              height: 1.7,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/miliana.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'الرؤية',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'أن تكون مليانة منارةً علميةً وروحيةً تُحيي تراثها التعليمي العريق.',
            style: TextStyle(fontSize: 18, color: AppColors.black, height: 1.8),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            'الرسالة',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'تكوين جيلٍ يجمع بين الأصالة والمعاصرة في طلب العلم وخدمة المجتمع.',
            style: TextStyle(fontSize: 18, color: AppColors.black, height: 1.8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
