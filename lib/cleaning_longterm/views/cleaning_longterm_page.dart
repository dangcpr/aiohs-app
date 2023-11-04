import 'package:flutter/material.dart';

import 'cleaning_longterm_screen_step1.dart';

class CleaningLongTermPage extends StatefulWidget {
  const CleaningLongTermPage({super.key});

  @override
  State<CleaningLongTermPage> createState() => _CleaningLongTermPageState();
}

class _CleaningLongTermPageState extends State<CleaningLongTermPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CleaningLongTermStep1(),
    );
  }
}
