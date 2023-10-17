import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utilities/cards/location_card.dart';
import '../utilities/constants/variable.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({super.key});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 0, 0),
            child: Text(
              AppLocalizations.of(context)!.needRoomForShortTerm,
              style: const TextStyle(
                fontFamily: fontBoldApp,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const LocationCard(),
        ],
      ),
    );
  }
}
