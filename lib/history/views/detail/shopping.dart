import 'package:flutter/material.dart';
import 'package:rmservice/history/models/shopping.dart';
import 'package:rmservice/history/widgets/shopping/location_info.dart';
import 'package:rmservice/history/widgets/shopping/work_info.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingHistoryDetail extends StatefulWidget {
  const ShoppingHistoryDetail({super.key, required this.order});

  final ShoppingHistory order;

  @override
  State<ShoppingHistoryDetail> createState() => _ShoppingHistoryDetailState();
}

class _ShoppingHistoryDetailState extends State<ShoppingHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn - Đi chợ hộ",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.mediumLarger,
          )
        )
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextLabel(
                        label: AppLocalizations.of(context)!.locationLabel,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                    // IconButton(
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateColor.resolveWith(
                    //       (states) => colorProject.primaryColor,
                    //     ),
                    //   ),
                    //   icon: Icon(color: Colors.white, Icons.edit),
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //       isScrollControlled: true,
                    //       context: context,
                    //       builder: (builder) {
                    //         return BottomEditNamePhone(isDarkMode: isDarkMode);
                    //       },
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
              LocationInfoShoppingHistory(
                isDarkMode: isDarkMode,
                order: widget.order,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: TextLabel(
                  label: AppLocalizations.of(context)!.workingInfoLabel,
                  isDarkMode: isDarkMode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: WorkInfoShoppingHistory(
                  isDarkMode: isDarkMode,
                  order: widget.order,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 17),
              //   child: WorkInfoCleaningHourly(
              //     isDarkMode: isDarkMode,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 17),
              //   child: TextLabel(
              //     label: 'Phương thức thanh toán',
              //     isDarkMode: isDarkMode,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 17),
              //   child: MethodPaymentShopping(
              //     isDarkMode: isDarkMode,
              //   ),
              // ),
              SizedBox(height: 15),
              ButtonGreenApp(label: "Hủy đơn này", onPressed: null),
              SizedBox(height: 8)
            ],
          ),
        ),
    );
  }
}