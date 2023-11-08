import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/place_page/views/create_rental_screen.dart';
import '../widgets/place_card.dart';
import '../../utilities/constants/variable.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({super.key});

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorProject.primaryColor,
        label: Text(
          "Bạn muốn cho thuê?",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.medium,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CreateRentalScreen(),
              type: PageTransitionType.rightToLeftWithFade,
              duration: Duration(milliseconds: 400),
            ),
          );
        },
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
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
