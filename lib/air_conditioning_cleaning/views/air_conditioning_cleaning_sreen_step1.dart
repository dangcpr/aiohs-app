import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/save_info_air_conditioning_cleaning.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../cleaning_hourly/views/maps.dart';
import '../../cleaning_hourly/widgets/button_app_bar.dart';
import '../../cleaning_longterm/widgets/button_next_step1.dart';
import '../widgets/types/am_tran/am_tran.dart';
import '../widgets/types/ap_tran/ap_tran.dart';
import '../widgets/types/giau_tran/giau_tran.dart';
import '../widgets/types/treo_tuong/treo_tuong.dart';
import '../widgets/types/tu_dung/tu_dung.dart';

class AirConditioningCleaningScreenStep1 extends StatefulWidget {
  const AirConditioningCleaningScreenStep1({super.key});

  @override
  State<AirConditioningCleaningScreenStep1> createState() =>
      _AirConditioningCleaningScreenStep1State();
}

class _AirConditioningCleaningScreenStep1State
    extends State<AirConditioningCleaningScreenStep1>
    with TickerProviderStateMixin {
  final List<Widget> pages = [
    const TreoTuong(),
    const TuDung(),
    const Amtran(),
    const ApTran(),
    const GiauTran(),
  ];

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
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
                  childCurrent: AirConditioningCleaningScreenStep1(),
                ),
              );
            },
          ),
          leading: InkWell(
            onTap: () {
              context.read<SaveInfoAirConditioningCleaningCubit>().setInitial();
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
          bottom: TabBar(
            indicatorColor: colorProject.primaryColor,
            isScrollable: true,
            labelStyle: textStyle.headerStyle(fontSize: 14),
            tabAlignment: TabAlignment.start,
            labelPadding: const EdgeInsets.only(right: padding.paddingLarge),
            labelColor: colorProject.primaryColor,
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: padding.paddingSmall),
            tabs: const [
              Tab(
                text: 'Treo tường',
              ),
              Tab(
                text: 'Tủ đứng',
              ),
              Tab(
                text: 'Âm trần',
              ),
              Tab(
                text: 'Áp trần',
              ),
              Tab(
                text: 'Giấu trần',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(padding.paddingMedium),
          child: TabBarView(
            children: [
              ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [pages[0]],
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [pages[1]],
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [pages[2]],
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [pages[3]],
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [pages[4]],
              ),
            ],
          ),
        ),
        // floatingActionButton: const ButtonNextStep1(),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterFloat,
        bottomNavigationBar: const ButtonNextStep1(),
      ),
    );
  }
}
