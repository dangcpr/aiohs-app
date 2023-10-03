import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rmservice/sign_up/cubits/signup_cubit.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/home_route/cubits/get_first_time/get_first_time_cubit.dart';
import 'package:rmservice/home_route/cubits/set_first_time/set_first_time_cubit.dart';
import 'package:rmservice/utilities/routes/route.dart';
import 'package:rmservice/utilities/themes/dark_theme.dart';
import 'package:rmservice/utilities/themes/light_theme.dart';
import 'package:rmservice/home_route/views/home_screen.dart';

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
        BlocProvider<SignupCubit>(
          create: (_) => SignupCubit(),
        ),
      ],
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
      home: HomeScreen(),
    );
  }
}
