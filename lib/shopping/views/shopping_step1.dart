import 'package:flutter/material.dart';
import 'package:rmservice/cleaning_hourly/widgets/text_sub_label.dart';
import 'package:rmservice/shopping/widgets/list_address.dart';
import 'package:rmservice/shopping/widgets/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingStep1Screen extends StatefulWidget {
  const ShoppingStep1Screen({super.key});

  @override
  State<ShoppingStep1Screen> createState() => _ShoppingStep1ScreenState();
}

class _ShoppingStep1ScreenState extends State<ShoppingStep1Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.shoppingStep1Title,
          style: TextStyle(fontSize: fontSize.mediumLarger),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: TextLabel(
                label: AppLocalizations.of(context)!.shoppingStep1Label,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TextSubLabel(
                label: AppLocalizations.of(context)!.shoppingStep1LabelSub,
                isDarkMode: isDarkMode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: ListAddress(),
            )
          ],
        ),
      ),
      // floatingActionButton: const ButtonNextStep1(),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
