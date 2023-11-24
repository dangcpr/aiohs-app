import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rmservice/shopping/widgets/method1_shopping_button.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ShoppingStep2Screen extends StatefulWidget {
  const ShoppingStep2Screen({super.key});

  @override
  State<ShoppingStep2Screen> createState() => _ShoppingStep2ScreenState();
}

class _ShoppingStep2ScreenState extends State<ShoppingStep2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.shoppingStep2Title,
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
        child: ListView(
          children: [
            Method1ShoppingButton(),
            SizedBox(
              height: 30,
            ),
            //Methoad2ShoppingButton()
          ],
        ),
      ),
    );
  }
}
