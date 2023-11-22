import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/laundry/cubits/price_laundry_cubit.dart';
import 'package:rmservice/laundry/widgets/count/bleaching.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ServiceCleaningCard extends StatefulWidget {
  const ServiceCleaningCard({super.key});

  @override
  State<ServiceCleaningCard> createState() => _ServiceCleaningCardState();
}

class _ServiceCleaningCardState extends State<ServiceCleaningCard> {
bool expanded = false;
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
          AppLocalizations.of(context)!.serviceCleaning,
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
                        "Tẩy trắng đồ giặt",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.mediumLarger,
                        ),
                      ),
                      Text(
                        formatter.format(priceLaundryCubit.state.bleaching) +
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
                BleachingServiceCount(),
              ],
            ),
            
          ],
        ),
        controller: ExpandableController(
          initialExpanded: expanded,
        ),
      ),
    );
  }
}