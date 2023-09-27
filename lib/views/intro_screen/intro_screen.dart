import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:rmservice/constants/function.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/views/intro_screen/set_first_time.dart';

class IntroScreenApp extends StatefulWidget {
  const IntroScreenApp({super.key});

  @override
  State<IntroScreenApp> createState() => _IntroScreenAppState();
}

class _IntroScreenAppState extends State<IntroScreenApp> {
  @override
  Widget build(BuildContext context) {
    final list = getOnbordingData(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: IntroScreen(
          onbordingDataList: list,
          colors: [
            Color(0xFF00B27D),
          ],
          pageRoute: MaterialPageRoute(
            builder: (context) => SetFirstTimeScreen(),
          ),
          nextButton: Text(
            AppLocalizations.of(context)!.next,
            style: TextStyle(
              color: Color(0xFF00B27D),
              fontFamily: 'GoogleSans-Bold',
            ),
          ),
          lastButton: Text(
            AppLocalizations.of(context)!.start,
            style: TextStyle(
              color: Color(0xFF00B27D),
              fontFamily: 'GoogleSans-Bold',
            ),
          ),
          skipButton: Text(
            AppLocalizations.of(context)!.pass,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'GoogleSans-Bold',
            ),
          ),
          selectedDotColor: Color(0xFF00B27D),
          unSelectdDotColor: Colors.grey,
        ),
      ),
    );
  }
}
