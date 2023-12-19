import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/cleaning_longterm/cubit/get_price/get_price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cleaning_longterm/cubit/save_info_cubit.dart';
import 'package:rmservice/utilities/components/show_address.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../cleaning_hourly/widgets/button_app_bar.dart';
import '../../utilities/components/text_label.dart';
import '../../utilities/components/text_sub_label.dart';
import '../cubit/price_cleaning_longterm_cubit.dart';
import '../widgets/button_next_step1.dart';
import '../widgets/duration_choices.dart';
import '../widgets/month_choice.dart';
import '../widgets/note_for_maid.dart';
import '../widgets/pick_time_work.dart';
import '../widgets/time_choice.dart';

class CleaningLongTermStep1 extends StatefulWidget {
  const CleaningLongTermStep1({super.key});

  @override
  State<CleaningLongTermStep1> createState() => _CleaningLongTermStep1State();
}

class _CleaningLongTermStep1State extends State<CleaningLongTermStep1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        'Start data: ${context.read<SaveInfoCleaningLongTermCubit>().state.toJson().toString()}');
  }

  NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'vi-VN');

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final TextEditingController numberOfMaid = TextEditingController();
    List<bool> values = List.filled(7, false);
    var priceCleaningLongTermCubit = context.read<PriceCleaningLongTermCubit>();
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
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return YourAddress();
              },
            );
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     duration: Duration(milliseconds: 400),
            //     type: PageTransitionType.rightToLeftWithFade,
            //     child: ChooseLocationScreen(),
            //   ),
            // );
          },
        ),
        leading: InkWell(
          onTap: () {
            context.read<SaveInfoCleaningLongTermCubit>().setInitial();
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<GetPriceCleaningLongtermCubit,
          GetPriceCleaningLongtermState>(
        builder: (context, state) {
          if (state is GetPriceCleaningLongtermLoading) {
            return Center(
              child:
                  CircularProgressIndicator(color: colorProject.primaryColor),
            );
          }
          if (state is GetPriceCleaningLongtermSuccess) {
            priceCleaningLongTermCubit
                .setPriceCleaningLongTerm(state.cleaningLongTermPrice);
            print(jsonEncode(priceCleaningLongTermCubit.state));
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: padding.paddingMedium),
                    child: TextLabel(
                      label: "Ngày",
                      isDarkMode: isDarkMode,
                    ),
                  ),
                  sizedBox.smallHeight(),
                  TimeChoice(isDarkMode: isDarkMode),
                  sizedBox.mediumHeight(),
                  TextLabel(
                    label: "Giờ bắt đầu",
                    isDarkMode: isDarkMode,
                  ),
                  PickTimeWork(
                    isDarkMode: isDarkMode,
                  ),
                  sizedBox.mediumHeight(),
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
                              .format(state.cleaningLongTermPrice.unitPrice) +
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
                  sizedBox.mediumHeight(),
                  TextLabel(
                    label: "Số tháng cần thuê",
                    isDarkMode: isDarkMode,
                  ),
                  MonthChoice(isDarkMode: isDarkMode),
                  sizedBox.mediumHeight(),
                  TextLabel(
                    label:
                        "Ghi chú cho người làm để người làm dọn dẹp tốt hơn.",
                    isDarkMode: isDarkMode,
                  ),
                  NoteForMaid(
                    isDarkMode: isDarkMode,
                  )
                ],
              ),
            );
          }
          if (state is GetPriceCleaningLongtermFailed) {
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
