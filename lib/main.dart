import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rmservice/splash_screen/views/splash_screen.dart';
import 'package:rmservice/utilities/constants/list_provider.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/routes/route.dart';
import 'package:rmservice/utilities/themes/dark_theme.dart';
import 'package:rmservice/utilities/themes/light_theme.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: listProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AIO Home Service',
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportLanguage,
      onGenerateRoute: Routes.controller,
      home: SplashScreen(),
    );
  }
}
