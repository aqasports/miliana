import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          // Header
          const Text(
            'المسارات التعليمية',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4A90E2),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'برامجنا',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'برامج متنوعة تناسب جميع المستويات والأعمار',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // Programs
          _buildProgramCard(
            '📚',
            'برنامج الطالب المبتدئ',
            'للمبتدئين في طلب العلم، يركز على حفظ القرآن والمتون الأساسية مع تعلم أساسيات الفقه واللغة.',
            'سنتان',
            'مبتدئ',
            'يومي',
            const Color(0xFF4ADE80),
          ),

          const SizedBox(height: 20),

          _buildProgramCard(
            '📖',
            'برنامج الطالب المتوسط',
            'دراسة معمقة للفقه واللغة والأصول مع التركيز على الفهم والتحليل والقدرة على الاستنباط.',
            '3-4 سنوات',
            'متوسط',
            'يومي',
            const Color(0xFFFBBF24),
          ),

          const SizedBox(height: 20),

          _buildProgramCard(
            '🎓',
            'برنامج الطالب المتقدم',
            'دراسة المتون المتقدمة والتخصص في أحد العلوم الشرعية أو اللغوية مع البحث والتأليف.',
            '3-5 سنوات',
            'متقدم',
            'يومي',
            const Color(0xFFEF4444),
          ),

          const SizedBox(height: 20),

          _buildProgramCard(
            '🌙',
            'البرنامج الصيفي',
            'برنامج مكثف خلال فترة الصيف للمراجعة والحفظ والدورات المتخصصة في العلوم الشرعية.',
            'شهران',
            'جميع المستويات',
            'يومي',
            const Color(0xFF8B5CF6),
          ),

          const SizedBox(height: 20),

          _buildProgramCard(
            '📅',
            'الدروس المسائية',
            'دروس مفتوحة للعامة في المساجد والزوايا بعد صلاة المغرب والعشاء في مختلف العلوم.',
            'يومياً',
            'للجميع',
            'مفتوح',
            const Color(0xFF06B6D4),
          ),

          const SizedBox(height: 20),

          _buildProgramCard(
            '🎤',
            'الندوات والمؤتمرات',
            'استضافة العلماء والباحثين لإثراء الساحة العلمية والفكرية وتبادل الخبرات والمعارف.',
            'شهرياً',
            'للجميع',
            'مفتوح',
            const Color(0xFFF59E0B),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildProgramCard(
    String icon,
    String title,
    String description,
    String duration,
    String level,
    String attendance,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.08 * 255).round()),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.deepBlue, const Color(0xFF4A90E2)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBlue,
                    fontFamily: 'Amiri',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
              height: 1.7,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2).withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildInfoRow('المدة:', duration, accentColor),
                const SizedBox(height: 8),
                _buildInfoRow('المستوى:', level, accentColor),
                const SizedBox(height: 8),
                _buildInfoRow('الحضور:', attendance, accentColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color accentColor) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.deepBlue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }
}