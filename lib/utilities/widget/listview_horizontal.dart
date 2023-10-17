import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/cleaning_hourly/views/maps.dart';
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
        onPressed: () {
          debugPrint('On pressed');
          //Route
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChooseLocationScreen(),
            )
          );
        },
      ),
      ServiceCard(
        icon: Icons.cleaning_services,
        width: 50,
        text: AppLocalizations.of(context)!.longTerm,
      ),
      ServiceCard(
        icon: Icons.ac_unit_outlined,
        width: 50,
        text: AppLocalizations.of(context)!.airConditioningCleaning,
      ),
      ServiceCard(
        icon: Icons.shopping_cart,
        width: 50,
        text: AppLocalizations.of(context)!.shopping,
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
