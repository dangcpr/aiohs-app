import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/widgets/count/comple.dart';
import 'package:rmservice/laundry/widgets/count/vietnamese_dress.dart';
import 'package:rmservice/laundry/widgets/count/weeding_dress.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DryCleaningCard extends StatefulWidget {
  const DryCleaningCard({super.key, this.priceType = 'LAUNDRY_PRICE_TYPE_KG'});

  final String priceType;

  @override
  State<DryCleaningCard> createState() => _DryCleaningCardState();
}

class _DryCleaningCardState extends State<DryCleaningCard> {
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
          iconColor: colorProject.primaryColor,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          alignment: Alignment.center,
          iconPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        header: Text(
          AppLocalizations.of(context)!.dryCleaning +
              (widget.priceType == 'LAUNDRY_PRICE_TYPE_KG' ? " (kg)" : " (bộ)"),
          style: TextStyle(
            // color: Colors.black,
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
                        "Com-lê",
                        style: TextStyle(
                          // color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter
                                    .format(priceLaundryCubit.state.comple_k) +
                                "/kg"
                            : formatter.format(priceLaundryCubit.state.comple) +
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
                CompleCount(),
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
                        "Áo dài",
                        style: TextStyle(
                          // color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter.format(
                                    priceLaundryCubit.state.vietnamDress_k) +
                                "/kg"
                            : formatter.format(
                                    priceLaundryCubit.state.vietnamDress) +
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
                VietnameseDressCount(),
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
                        "Áo cưới",
                        style: TextStyle(
                          // color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        widget.priceType == 'LAUNDRY_PRICE_TYPE_KG'
                            ? formatter.format(
                                    priceLaundryCubit.state.weedingDress_k) +
                                "/kg"
                            : formatter.format(
                                    priceLaundryCubit.state.weedingDress) +
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
                WeedingDressCount(),
              ],
            ),
          ],
        ),
        controller: additionalInfoController,
      ),
    );
  }
}
