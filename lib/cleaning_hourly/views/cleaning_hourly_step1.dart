import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/get_price_cleaning_hourly/get_price_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/get_price_cleaning_hourly/get_price_cleaning_hourly_state.dart';
import 'package:rmservice/cleaning_hourly/cubits/price_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/views/maps.dart';
import 'package:rmservice/cleaning_hourly/widgets/add_service_choice.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_app_bar.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_next_step1.dart';
import 'package:rmservice/cleaning_hourly/widgets/duration_choice.dart';
import 'package:rmservice/cleaning_hourly/widgets/notice_step1.dart';
import 'package:rmservice/cleaning_hourly/widgets/pet_choice.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/text_sub_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class CleaningHourlyStep1Screen extends StatefulWidget {
  const CleaningHourlyStep1Screen({super.key});

  @override
  State<CleaningHourlyStep1Screen> createState() =>
      _CleaningHourlyStep1ScreenState();
}

class _CleaningHourlyStep1ScreenState extends State<CleaningHourlyStep1Screen> {
  NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var priceCleaningHourlyCubit = context.read<PriceCleaningHourlyCubit>();
    var infoCleaningHourly = context.read<SaveInfoCleaningHourlyCubit>().state;
    var caculateCHPriceCubit = context.read<CaculatePriceCleaningHourlyCubit>();

    @override
    void initState() {
      super.initState();
    }

    caculateCHPriceCubit.caculatePrice(infoCleaningHourly);
    
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ButtonChooseLocation(
          nameLocation: context.watch<SaveAddressCubit>().state == null ||
                  context.watch<SaveAddressCubit>().state!.shortAddress == ""
              ? "Vui lòng chọn địa điểm"
              : context.watch<SaveAddressCubit>().state!.shortAddress!,
          addressLocation: context.watch<SaveAddressCubit>().state == null ||
                  context.watch<SaveAddressCubit>().state!.address == ""
              ? "Vui lòng chọn địa điểm"
              : context.watch<SaveAddressCubit>().state!.address!,
          isDarkMode: isDarkMode,
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 400),
                type: PageTransitionType.rightToLeftWithFade,
                child: ChooseLocationScreen(),
                childCurrent: CleaningHourlyStep1Screen(),
              ),
            );
          },
        ),
      ),
      body:
          BlocBuilder<GetPriceCleaningHourlyCubit, GetPriceCleaningHourlyState>(
        builder: (context, state) {
          if (state is GetPriceCleaningHourlyLoading) {
            return Center(
              child:
                  CircularProgressIndicator(color: colorProject.primaryColor),
            );
          }

          if (state is GetPriceCleaningHourlySuccess) {
            priceCleaningHourlyCubit
                .setPriceCleaningHourly(state.cleaningHourlyPrice);

            debugPrint(jsonEncode(priceCleaningHourlyCubit.state));
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: TextLabel(
                      label: AppLocalizations.of(context)!.durationLabel,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextSubLabel(
                      label: AppLocalizations.of(context)!.durationSub +
                          "\nĐơn giá: " +
                          numberFormat
                              .format(state.cleaningHourlyPrice.unitPrice) +
                          "/giờ",
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: DurationChoice(
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: TextLabel(
                      label: AppLocalizations.of(context)!.addServiceLabel,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextSubLabel(
                      label: AppLocalizations.of(context)!.durationSub,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: AddServiceChoice(
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextLabel(
                      label: AppLocalizations.of(context)!.optionLabel,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PetChoice(
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: NoticeStep1(
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GetPriceCleaningHourlyError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: const ButtonNextStep1(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
