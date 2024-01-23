import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/widgets/count/blanket.dart';
import 'package:rmservice/laundry/widgets/count/clothes.dart';
import 'package:rmservice/laundry/widgets/count/drap.dart';
import 'package:rmservice/laundry/widgets/count/mosquito.dart';
import 'package:rmservice/laundry/widgets/count/net.dart';
import 'package:rmservice/laundry/widgets/count/pillow.dart';
import 'package:rmservice/laundry/widgets/count/topper.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NormalCleaningCard extends StatefulWidget {
  const NormalCleaningCard(
      {super.key, this.priceType = 'LAUNDRY_PRICE_TYPE_KG'});

  final String priceType;

  @override
  State<NormalCleaningCard> createState() => _NormalCleaningCardState();
}

class _NormalCleaningCardState extends State<NormalCleaningCard> {
  static bool expanded = false;

  ExpandableController additionalInfoController = ExpandableController(
    initialExpanded: expanded,
  );

  @override
  void initState() {
    super.initState();
    additionalInfoController.addListener(() {
      expanded = !expanded;
    });
  }

  final formatter = NumberFormat.simpleCurrency(locale: "vi-VN");
  @override
  Widget build(BuildContext context) {
    var priceLaundryCubit = context.watch<PriceLaundryCubit>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorProject.primaryColor,
          width: 0.5,
        ),
      ),
      padding: EdgeInsets.all(10),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          alignment: Alignment.center,
          iconPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        header: Text(
          AppLocalizations.of(context)!.normalCleaning,
          style: TextStyle(
            color: Colors.black,
            fontFamily: fontBoldApp,
            fontSize: fontSize.mediumLarger + 2,
          ),
        ),
        collapsed: SizedBox(height: 0),
        expanded: Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quần áo",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter
                                    .format(priceLaundryCubit.state.clothes_k) +
                                "/kg"
                            : formatter
                                    .format(priceLaundryCubit.state.clothes) +
                                "/bộ",
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                ClothesCount(),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mền",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter
                                    .format(priceLaundryCubit.state.blanket_k) +
                                "/kg"
                            : formatter
                                    .format(priceLaundryCubit.state.blanket) +
                                "/bộ",
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                BlanketCount(),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mùng chống muỗi",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter
                                    .format(priceLaundryCubit.state.mosquito_k) +
                                "/kg"
                            : formatter
                                    .format(priceLaundryCubit.state.mosquito) +
                                "/bộ",
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                MosquitoCount(),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lưới chống muỗi",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter
                                    .format(priceLaundryCubit.state.net_k) +
                                "/kg"
                            : formatter.format(priceLaundryCubit.state.net) +
                                "/bộ",
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                NetCount(),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Drap",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter.format(priceLaundryCubit.state.drap_k) +
                                "/kg"
                            : formatter.format(priceLaundryCubit.state.drap) +
                                "/bộ",
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                DrapCount(),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tấm phủ nệm",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter.format(priceLaundryCubit.state.topper_k) +
                                "/kg"
                            : formatter.format(priceLaundryCubit.state.topper) +
                                "/bộ",
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                TopperCount(),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gối",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter.format(priceLaundryCubit.state.pillow_k) +
                                "/kg"
                            : formatter.format(priceLaundryCubit.state.pillow) +
                                "/bộ",
                        style: TextStyle(
                          color: colorProject.primaryColor,
                          fontFamily: fontApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
                    ],
                  ),
                ),
                PillowCount(),
              ],
            ),
          ],
        ),
        controller: additionalInfoController,
      ),
    );
  }
}
