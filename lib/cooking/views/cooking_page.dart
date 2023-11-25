import 'package:flutter/material.dart';
import 'package:rmservice/cooking/views/cooking_screen_step1.dart';

class CookingPage extends StatefulWidget {
  const CookingPage({super.key});

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends State<CookingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CookingScreenStep1(),
    );
  }
}
