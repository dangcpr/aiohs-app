import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/views/air_conditioning_cleaning_page.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step1.dart';
import 'package:rmservice/cleaning_longterm/cleaning_longterm.dart';
import 'package:rmservice/main_page/main_page.dart';
import 'package:rmservice/shopping/views/shopping_step1.dart';

import 'package:rmservice/utilities/constants/variable.dart';
import '../cards/service_card.dart';

class HorizontalListViewWithIndicator extends StatefulWidget {
  const HorizontalListViewWithIndicator({super.key});

  @override
  _HorizontalListViewWithIndicatorState createState() =>
      _HorizontalListViewWithIndicatorState();
}

class _HorizontalListViewWithIndicatorState
    extends State<HorizontalListViewWithIndicator> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      ServiceCard(
        icon: Icons.access_alarm,
        width: 50,
        text: AppLocalizations.of(context)!.hourly,
        //color: colorProject.primaryColor.withOpacity(0.65),
        onPressed: () {
          debugPrint('On pressed');
          //Route
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: CleaningHourlyStep1Screen(),
              childCurrent: MainPage(),
            ),
          );
        },
      ),
      ServiceCard(
        icon: Icons.cleaning_services,
        width: 50,
        text: AppLocalizations.of(context)!.longTerm,
        //color: Color(0xff0e5bb0).withOpacity(0.65),
        onPressed: () {
          debugPrint('On pressed');
          //Route
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: CleaningLongTermPage(),
                  childCurrent: MainPage()));
        },
      ),
      ServiceCard(
        icon: Icons.ac_unit_outlined,
        //color: Color(0xffFF9A00).withOpacity(0.65),
        width: 50,
        text: AppLocalizations.of(context)!.airConditioningCleaning,
        onPressed: () {
          debugPrint('On pressed');
          //Route
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: AirConditioningCleaningPage(),
                  childCurrent: MainPage()));
        },
      ),
      ServiceCard(
        icon: Icons.shopping_cart,
        width: 50,
        //color: Color(0xffFF5900).withOpacity(0.65),
        text: AppLocalizations.of(context)!.shopping,
        onPressed: () {
          debugPrint('On pressed Shopping');
          //Route
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 500),
              type: PageTransitionType.rightToLeftWithFade,
              child: ShoppingStep1Screen(),
              childCurrent: MainPage(),
            ),
          );
        },
      ),
      ServiceCard(
        icon: Icons.menu,
        width: 50,
        text: AppLocalizations.of(context)!.options,
      ),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        items[0],
        items[1],
        items[2],
        items[3],
        items[4],
      ],
    );
  }
}
