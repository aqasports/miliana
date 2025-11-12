import 'package:flutter/material.dart';

class ScholarsPage extends StatelessWidget {
  const ScholarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'برز من مليانة عدد من العلماء المتميزين في الفقه والحديث واللغة، وكان لهم دور رائد في نشر العلم في الجزائر والمغرب العربي.',
        style: TextStyle(fontSize: 18, height: 1.8),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
