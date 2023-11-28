import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cooking/cubit/get_price_cooking/get_price_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/price_cooking_cubit.dart';
import 'package:rmservice/cooking/cubit/save_info_cooking.dart';
import 'package:rmservice/cooking/model/cooking_price.dart';
import 'package:rmservice/cooking/widgets/service_bonus.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../cleaning_hourly/cubits/price_cleaning_hourly_cubit.dart';
import '../../cleaning_hourly/cubits/save_info/save_address.dart';
import '../../cleaning_hourly/views/maps.dart';
import '../../cleaning_hourly/widgets/button_app_bar.dart';
import '../widgets/button_next_step1.dart';
import '../widgets/dessert.dart';
import '../widgets/dishes.dart';
import '../widgets/number_of_people.dart';
import '../widgets/optionals.dart';
import '../widgets/taste.dart';

class CookingScreenStep1 extends StatefulWidget {
  const CookingScreenStep1({super.key});

  @override
  State<CookingScreenStep1> createState() => _CookingScreenStep1State();
}

class _CookingScreenStep1State extends State<CookingScreenStep1> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var priceCookingCubit = context.read<CookingPriceCubit>();
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
                childCurrent: CookingScreenStep1(),
              ),
            );
          },
        ),
        leading: InkWell(
          onTap: () {
            context.read<SaveInfoCookingCubit>().setInitial();
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<GetPriceCookingCubit, GetPriceCookingState>(
        builder: (context, state) {
          if (state is GetPriceCookingLoading) {
            return Center(
              child:
                  CircularProgressIndicator(color: colorProject.primaryColor),
            );
          }
          if (state is GetPriceCookingSuccess) {
            priceCookingCubit.setPriceCleaningHourly(state.cookingPrice);
            debugPrint(jsonEncode(priceCookingCubit.state));
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 90),
              child: ListView(
                children: [
                  Text(
                    'Số người ăn',
                    style: textStyle.headerStyle(fontSize: 14),
                  ),
                  sizedBox.mediumHeight(),
                  NumberOfPeople(),
                  sizedBox.largeHeight(),
                  Text(
                    'Số món ăn',
                    style: textStyle.headerStyle(fontSize: 14),
                  ),
                  sizedBox.mediumHeight(),
                  Dishes(),
                  sizedBox.largeHeight(),
                  Text(
                    'Khẩu vị',
                    style: textStyle.headerStyle(fontSize: 14),
                  ),
                  sizedBox.mediumHeight(),
                  Taste(),
                  sizedBox.largeHeight(),
                  Text(
                    'Món tráng miệng',
                    style: textStyle.headerStyle(fontSize: 14),
                  ),
                  sizedBox.mediumHeight(),
                  Dessert(),
                  sizedBox.largeHeight(),
                  Text(
                    'Dịch vụ thêm',
                    style: textStyle.headerStyle(fontSize: 14),
                  ),
                  sizedBox.mediumHeight(),
                  ServiceBonus(),
                  sizedBox.largeHeight(),
                  Text(
                    'Tùy chọn',
                    style: textStyle.headerStyle(fontSize: 18),
                  ),
                  sizedBox.mediumHeight(),
                  Optionals(),
                ],
              ),
            );
          }
          if (state is GetPriceCookingFailed) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(child: Container(child: Text('Loi')));
          }
        },
      ),
      floatingActionButton: const ButtonNextStep1(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
