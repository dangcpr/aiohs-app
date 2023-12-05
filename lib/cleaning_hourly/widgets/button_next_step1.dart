import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_cubit.dart';
import 'package:rmservice/cleaning_hourly/cubits/caculate_price/caculate_price_state.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_info.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step1.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step2.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonNextStep1 extends StatefulWidget {
  const ButtonNextStep1({super.key});

  @override
  State<ButtonNextStep1> createState() => _ButtonNextStep1State();
}

class _ButtonNextStep1State extends State<ButtonNextStep1> {
  @override
  Widget build(BuildContext context) {
    var caculateCHPriceCubit = context.watch<CaculatePriceCleaningHourlyCubit>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: caculateCHPriceCubit.state is CaculatePriceCleaningHourlyLoading
          ? const ElevatedButton(onPressed: null, child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.grey)))
          : caculateCHPriceCubit.state is CaculatePriceCleaningHourlyError
              ? const ElevatedButton(onPressed: null, child: Text("Đã có lỗi xảy ra"))
              : ButtonGreenApp(
                  label: AppLocalizations.of(context)!.nextLabel,
                  onPressed: () {
                    int cooking = context
                                .read<SaveInfoCleaningHourlyCubit>()
                                .state
                                .cooking! ==
                            true
                        ? 1
                        : 0;
                    int iron = context
                                .read<SaveInfoCleaningHourlyCubit>()
                                .state
                                .iron! ==
                            true
                        ? 1
                        : 0;
                    context
                        .read<SaveInfoCleaningHourlyCubit>()
                        .state
                        .realDuration = context
                            .read<SaveInfoCleaningHourlyCubit>()
                            .state
                            .duration! +
                        cooking +
                        iron;
                    if (context
                            .read<SaveInfoCleaningHourlyCubit>()
                            .state
                            .realDuration! >
                        4) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialogWrong(
                              notification:
                                  "Tổng thời gian làm tính cả dịch vụ gia tăng là " +
                                      context
                                          .read<SaveInfoCleaningHourlyCubit>()
                                          .state
                                          .realDuration
                                          .toString() +
                                      " giờ. Vui lòng lựa chọn lại sao cho thời gian làm dưới 4 giờ",
                            );
                          });
                      return;
                    }
                    if (context.read<SaveAddressCubit>().state == null ||
                        context.read<SaveAddressCubit>().state!.address == "") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DialogWrong(
                              notification: "Vui lòng chọn địa điểm làm việc",
                            );
                          });
                      return;
                    }

                    Navigator.push(
                      context,
                      PageTransition(
                        duration: Duration(milliseconds: 400),
                        type: PageTransitionType.rightToLeftWithFade,
                        child: CleaningHourlyStep2Screen(),
                        childCurrent: CleaningHourlyStep1Screen(),
                      ),
                    );
                  },
                ),
    );
  }
}
