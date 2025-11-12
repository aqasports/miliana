import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class MitaqPage extends StatelessWidget {
  const MitaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            'ميثاق التأسيس',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'الوثيقة التأسيسية والأسس والمبادئ التي يقوم عليها مشروع حاضرة مليانة',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // Vision Section
          _buildSection(
            title: '🌟 الرؤية',
            content:
                'أن تكون حاضرة مليانة منارةً للعلم الأصيل والتربية الأخلاقية، تُعيد إلى الأمة نموذج التعليم التلقيني الحر القائم على الصحبة والسند، وتُخرّج علماء ربانيين يربطون بين نصوص الوحي ومقاصد الحياة.',
          ),
          const SizedBox(height: 24),

          // Mission Section
          _buildMissionSection(),
          const SizedBox(height: 24),

          // Strategic Goals
          _buildGoalsSection(),
          const SizedBox(height: 24),

          // Core Principles
          _buildPrinciplesSection(),
          const SizedBox(height: 24),

          // Educational Foundations
          _buildFoundationsSection(),
          const SizedBox(height: 30),

          // Download Button
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.deepBlue, AppColors.lightBlue],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('جاري تحميل الميثاق الكامل...'),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.download, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'تحميل الميثاق كاملاً (PDF)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.deepBlue.withAlpha((0.2 * 255).round()),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF475569),
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    final missions = [
      'إحياء نموذج المحضرة الشنقيطية',
      'إعادة تأهيل المساجد والزوايا',
      'نشر العلوم الشرعية والعقلية',
      'إعداد علماء ربانيين',
      'غرس قيمة العلم كعبادة',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.deepBlue.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎯 الرسالة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 16),
          ...missions.map((mission) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      mission,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF475569),
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildGoalsSection() {
    final goals = [
      'تخريج 100 طالب علم سنوياً',
      'إحياء 10 مساجد كمراكز علم',
      'توثيق تراث المنطقة العلمي',
      'بناء شبكة علماء إقليمية',
      'نشر 20 متناً محققاً',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.deepBlue.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 الأهداف الاستراتيجية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 16),
          ...goals.map((goal) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      goal,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF475569),
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPrinciplesSection() {
    final principles = [
      ('الحرية في الطلب',
          'الطالب يختار شيخه ومنهجه بناء على ميوله واستعداده'),
      ('الصحبة والسند',
          'التعلم بالمعايشة والتلقي المباشر من العلماء'),
      ('التدرج المنهجي',
          'من القرآن إلى الفقه إلى العلوم العقلية بتدرج محكم'),
      ('العمل بالعلم',
          'لا علم بلا عمل ولا عمل بلا نية صادقة'),
      ('الأدب والتزكية',
          'الأدب مفتاح العلم والتزكية طريق المعرفة'),
      ('خدمة المجتمع',
          'العلم مسؤولية مجتمعية ورسالة حضارية'),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.deepBlue.withAlpha((0.05 * 255).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.deepBlue.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚖️ المبادئ الأساسية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 16),
          ...principles.map((principle) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    principle.$1,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    principle.$2,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFoundationsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.deepBlue.withAlpha((0.05 * 255).round()), AppColors.lightBlue.withAlpha((0.05 * 255).round())],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.deepBlue.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📚 الأسس التربوية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
              fontFamily: 'Amiri',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'تقوم المحاضر على نموذج تربوي متكامل يجمع بين:',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF475569),
              height: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildFoundationItem('حفظ القرآن والعلوم الشرعية الأساسية'),
          _buildFoundationItem('دراسة المتون المعتمدة بالشرح والتحليل'),
          _buildFoundationItem('التركيز على الفهم والاستنباط لا الحفظ البرطالي'),
          _buildFoundationItem('المشاركة الفعالة للطالب في الحلقات'),
          _buildFoundationItem('بناء علاقة صحية بين الشيخ والطالب'),
          _buildFoundationItem('التركيز على تزكية النفس والآداب الإسلامية'),
        ],
      ),
    );
  }

  Widget _buildFoundationItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 8, right: 12),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF475569),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
