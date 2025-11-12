import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/mutun_model.dart';

class MutunDetailPage extends StatelessWidget {
  final Mutun mutun;

  const MutunDetailPage({super.key, required this.mutun});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: Text(
          mutun.name,
          style: const TextStyle(
            fontFamily: 'Amiri',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.deepBlue,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header card with maten info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.deepBlue, AppColors.lightBlue],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mutun.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Amiri',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'المؤلف: ${mutun.author}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      mutun.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Reserve Lesson Section
              _buildSectionTitle('حجز درس'),
              const SizedBox(height: 12),
              _buildActionCard(
                context,
                'احجز درسك الآن',
                'استفد من دروس مباشرة متخصصة في هذا المتن',
                Icons.calendar_today,
                AppColors.deepBlue,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('سيتم توجيهك إلى صفحة حجز الدروس')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Sharh Videos Section
              _buildSectionTitle('فيديوهات الشرح'),
              const SizedBox(height: 12),
              if (mutun.sharhVideoUrls.isNotEmpty)
                ...List.generate(mutun.sharhVideoUrls.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildVideoCard(
                      context,
                      'الدرس ${index + 1}',
                      'شرح مفصل للمتن',
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('سيتم فتح الفيديو: الدرس ${index + 1}'),
                          ),
                        );
                      },
                    ),
                  );
                })
              else
                const Text('لا توجد فيديوهات متاحة حالياً'),
              const SizedBox(height: 20),

              // Download PDF Section
              _buildSectionTitle('تحميل الملفات'),
              const SizedBox(height: 12),
              _buildActionCard(
                context,
                'تحميل المتن (PDF)',
                'حمّل النص الأصلي للمتن',
                Icons.download,
                const Color(0xFF10B981),
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('جاري تحميل المتن...')),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                context,
                'تحميل الشرح (PDF)',
                'حمّل شرح المتن الكامل',
                Icons.download,
                const Color(0xFFF59E0B),
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('جاري تحميل الشرح...')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Free Book Order Section
              _buildSectionTitle('اطلب الشرح مجاناً'),
              const SizedBox(height: 12),
              _buildActionCard(
                context,
                'اطلب نسخة من شرح ${mutun.bookAuthor}',
                'احصل على نسخة مطبوعة من الشرح بشكل مجاني',
                Icons.local_shipping,
                const Color(0xFF8B5CF6),
                () {
                  _showBookOrderDialog(context);
                },
              ),
              const SizedBox(height: 20),

              // More Information Section
              _buildSectionTitle('معلومات إضافية'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
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
                      'عن هذا الشرح',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      mutun.bookDescription,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF475569),
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.person, color: AppColors.deepBlue, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'الشارح: ${mutun.bookAuthor}',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.deepBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.deepBlue,
        fontFamily: 'Amiri',
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha((0.15 * 255).round()),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: color.withAlpha((0.2 * 255).round()),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, color: color, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).round()),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightBlue.withAlpha((0.1 * 255).round()),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.play_circle_fill,
                color: AppColors.lightBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, color: AppColors.lightBlue, size: 20),
          ],
        ),
      ),
    );
  }

  void _showBookOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'اطلب النسخة المطبوعة',
            style: TextStyle(
              fontFamily: 'Amiri',
              color: AppColors.deepBlue,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'للحصول على نسخة مطبوعة مجانية من:',
                style: const TextStyle(fontSize: 14, height: 1.6),
              ),
              const SizedBox(height: 8),
              Text(
                '${mutun.bookTitle}\nللشيخ ${mutun.bookAuthor}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBlue,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'اسمك الكامل',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: 'رقم الهاتف',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'العنوان',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deepBlue,
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تسجيل طلبك بنجاح! سنتواصل معك قريباً'),
                  ),
                );
              },
              child: const Text(
                'تأكيد',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
