import 'package:flutter/material.dart';
import 'custom_app_bar.dart';

class BaseLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final String route;

  const BaseLayout({
    Key? key,
    required this.title,
    required this.child,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title, currentRoute: route),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
