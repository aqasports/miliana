import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'عرفت مليانة منذ قرون بأنها مركز علمي نابض، احتضنت العلماء والطلبة، وأسست لتقليد علمي راسخ امتد عبر الأجيال.',
        style: TextStyle(fontSize: 18, height: 1.8),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
