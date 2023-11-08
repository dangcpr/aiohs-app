import 'package:flutter/material.dart';

import 'air_conditioning_cleaning_sreen_step1.dart';

class AirConditioningCleaningPage extends StatefulWidget {
  const AirConditioningCleaningPage({super.key});

  @override
  State<AirConditioningCleaningPage> createState() =>
      _AirConditioningCleaningPageState();
}

class _AirConditioningCleaningPageState
    extends State<AirConditioningCleaningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AirConditioningCleaningScreenStep1(),
    );
  }
}
