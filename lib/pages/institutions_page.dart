import 'package:flutter/material.dart';

class InstitutionsPage extends StatelessWidget {
  const InstitutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'تتعاون الحاضرة مع مؤسسات ومراكز تعليمية لإحياء النموذج العلمي الأصيل، وتطوير برامج تعليمية معاصرة.',
        style: TextStyle(fontSize: 18, height: 1.8),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
