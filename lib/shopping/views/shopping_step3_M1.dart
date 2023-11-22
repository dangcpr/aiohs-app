import 'package:flutter/material.dart';
import 'package:rmservice/utilities/components/text_sub_label.dart';
import 'package:rmservice/shopping/widgets/floating_step3.dart';
import 'package:rmservice/shopping/widgets/label_step3_list.dart';
import 'package:rmservice/shopping/widgets/list_product.dart';
import 'package:rmservice/shopping/widgets/text_field_product.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingStep3Method1Screen extends StatefulWidget {
  const ShoppingStep3Method1Screen({super.key});

  @override
  State<ShoppingStep3Method1Screen> createState() =>
      _ShoppingStep3Method1ScreenState();
}

class _ShoppingStep3Method1ScreenState
    extends State<ShoppingStep3Method1Screen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.shoppingStep3Title,
          style: TextStyle(
            fontSize: fontSize.mediumLarger,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 170),
        child: ListView(
          children: [
            TextFieldProduct(
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 17),
            LabelStep3List(isDarkMode: isDarkMode),
            SizedBox(height: 5),
            TextSubLabel(
              label: AppLocalizations.of(context)!.shoppingStep3Sub1,
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 10),
            ListProduct(isRemove: true),
          ],
        ),
      ),
      floatingActionButton: FloatingStep3(
        isDarkMode: isDarkMode,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
