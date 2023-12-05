import 'package:flutter/material.dart';
import 'package:rmservice/history/models/laundry.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationInfoLaundryHistory extends StatefulWidget {
  const LocationInfoLaundryHistory({super.key, required this.isDarkMode, required this.order});

  final bool isDarkMode;
  final LaundryHistory order;

  @override
  State<LocationInfoLaundryHistory> createState() => _LocationInfoLaundryHistoryState();
}

class _LocationInfoLaundryHistoryState extends State<LocationInfoLaundryHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color.fromARGB(172, 172, 172, 172), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   context.watch<SaveAddressCubit>().state!.shortAddress!,
            //   style: TextStyle(
            //     fontSize: fontSize.mediumLarger,
            //     fontFamily: fontBoldApp,
            //     color: colorProject.primaryColor,
            //   ),
            // ),
            // Text(
            //   "Nhà riêng",
            //   style: TextStyle(
            //     fontSize: fontSize.medium,
            //     fontFamily: fontApp,
            //     color: widget.isDarkMode ? Colors.white : Colors.black,
            //   ),
            // ),
            Text(
              AppLocalizations.of(context)!.locationDetailLabel,
              style: TextStyle(
                fontSize: fontSize.medium,
                fontFamily: fontBoldApp,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            // SizedBox(height: 5),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Icon(
            //       Icons.person,
            //       color: colorProject.primaryColor,
            //     ),
            //     SizedBox(width: 8),
            //     Flexible(
            //       child: Text(
            //         context.watch<SaveAddressCubit>().state!.name!,
            //         style: TextStyle(
            //           fontSize: fontSize.medium,
            //           fontFamily: fontApp,
            //           color: widget.isDarkMode ? Colors.white : Colors.black,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 5),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Icon(
            //       Icons.phone,
            //       color: colorProject.primaryColor,
            //     ),
            //     SizedBox(width: 8),
            //     Flexible(
            //       child: Text(
            //         context.watch<SaveAddressCubit>().state!.phone!,
            //         style: TextStyle(
            //           fontSize: fontSize.medium,
            //           fontFamily: fontApp,
            //           color: widget.isDarkMode ? Colors.white : Colors.black,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: colorProject.primaryColor,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    widget.order.working_address,
                    style: TextStyle(
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
