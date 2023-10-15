import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/themes/dark_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utilities/cards/location_card.dart';
import '../../utilities/cards/service_card.dart';
import '../../utilities/widget/listview_horizontal.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool darkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Appbar(),
                const SizedBox(height: 12),
                ProfileWidget(),
                const SizedBox(height: 10),
                Register(),
                const SizedBox(height: 10),
                SearchBox(),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.services,
                  style: const TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: 20,
                  ),
                ),
                HorizontalListViewWithIndicator(),
                const SizedBox(height: 15),
                Text(
                  AppLocalizations.of(context)!.needRoomForShortTerm,
                  style: const TextStyle(
                    fontFamily: fontBoldApp,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                const LocationCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ProfileWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 85,
          width: 85,
          child: CircleAvatar(
            child: Image.asset('assets/images/profile.png'),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.hello,
              style: const TextStyle(
                fontFamily: fontApp,
                fontSize: fontSize.large,
                color: colorProject.subColor,
              ),
            ),
            const Text(
              'Le Thanh Nam',
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.large,
                color: colorProject.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget Register() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 65,
      width: size.width,
      decoration: BoxDecoration(
        color: colorProject.primaryColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.becomeAMaid,
              style: const TextStyle(
                fontFamily: fontApp,
              ),
            ),
            Container(
              height: 27,
              width: 102,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.register,
                  style: const TextStyle(
                    fontFamily: fontBoldApp,
                    color: colorProject.primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget SearchBox() {
    final TextEditingController _searchText = TextEditingController();
    return SizedBox(
      height: 35,
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: _searchText,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: colorProject.primaryColor,
          ),
          suffixIcon: InkWell(
            child: const Icon(Icons.close),
            onTap: () {
              _searchText.clear();
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorProject.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: AppLocalizations.of(context)!.search,
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        style: const TextStyle(
          fontFamily: fontApp,
        ),
        cursorColor: colorProject.primaryColor,
      ),
    );
  }

  Widget Appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            const Text(
              'AIOHS',
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.large,
                color: colorProject.primaryColor,
              ),
            ),
          ],
        ),
        const Row(
          children: [
            Icon(
              Icons.notifications,
              color: colorProject.primaryColor,
            ),
            SizedBox(width: 20),
            Icon(
              Icons.account_circle_sharp,
              color: colorProject.primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
