import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/constants/variable.dart';
import 'package:rmservice/cubits/get_first_time/get_first_time_cubit.dart';
import 'package:rmservice/cubits/set_first_time/set_first_time_cubit.dart';
import 'package:rmservice/themes/dark_theme.dart';
import 'package:rmservice/themes/light_theme.dart';
import 'package:rmservice/views/home_screen.dart';

void main() {

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SetFirstTimeCubit>(
          create: (_) => SetFirstTimeCubit(),
        ),

        BlocProvider<GetFirstTimeCubit>(
          create: (_) => GetFirstTimeCubit(),
        ),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service-and-Space',
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportLanguage,
      home: HomeScreen()
    );
  }
}