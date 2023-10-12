import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cards/service_card.dart';

class HorizontalListViewWithIndicator extends StatefulWidget {
  @override
  _HorizontalListViewWithIndicatorState createState() =>
      _HorizontalListViewWithIndicatorState();
}

class _HorizontalListViewWithIndicatorState
    extends State<HorizontalListViewWithIndicator> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      ServiceCard(
        icon: Icons.access_alarm,
        width: 50,
        text: AppLocalizations.of(context)!.hourly,
      ),
      ServiceCard(
        icon: Icons.cleaning_services,
        width: 50,
        text: AppLocalizations.of(context)!.timeToTime,
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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.all(10),
                  child: items[index],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) {
              return Container(
                margin: const EdgeInsets.all(5),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
