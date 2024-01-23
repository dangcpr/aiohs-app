import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_app_bar.dart';
import 'package:rmservice/laundry/constants/price_type.dart';
import 'package:rmservice/laundry/cubits/calculate_laundry/calculate_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/get_price_laundry/get_price_laundry_cubit.dart';
import 'package:rmservice/laundry/cubits/get_price_laundry/get_price_laundry_state.dart';
import 'package:rmservice/laundry/cubits/save_info_laundry_cubit.dart';
import 'package:rmservice/laundry/helpers/set_price_laundry.dart';
import 'package:rmservice/laundry/widgets/button/button_next_step1.dart';
import 'package:rmservice/laundry/widgets/card/dry_cleaning_card.dart';
import 'package:rmservice/laundry/widgets/card/normal_cleaning_card.dart';
import 'package:rmservice/laundry/widgets/card/service_cleaning_card.dart';
import 'package:rmservice/utilities/components/show_address.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class LaundryStep1Screen extends StatefulWidget {
  const LaundryStep1Screen({super.key});

  @override
  State<LaundryStep1Screen> createState() => _LaundryStep1ScreenState();
}

class _LaundryStep1ScreenState extends State<LaundryStep1Screen> {
  int priceTypeChoice = 0;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

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
      ),
      body: BlocBuilder<GetPriceLaundryCubit, GetPriceLaundryState>(
        builder: (context, state) {
          if (state is GetPriceLaundrySuccess) {
            setPriceLaundry(state.priceLaundry, context);

            return Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, bottom: 90, top: 20),
              child: Container(
                //padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(
                      label: "Vui lòng chọn những thứ bạn muốn giặt ủi",
                      isDarkMode: isDarkMode,
                    ),
                    choicePricetype(),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NormalCleaningCard(
                                priceType: priceTypes[priceTypeChoice].code),
                            SizedBox(height: 10),
                            DryCleaningCard(
                                priceType: priceTypes[priceTypeChoice].code),
                            SizedBox(height: 10),
                            ServiceCleaningCard(
                                priceType: priceTypes[priceTypeChoice].code),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is GetPriceLaundryLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(color: colorProject.primaryColor),
            );
          }
          if (state is GetPriceLaundryError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: ButtonNextStep1Laundry(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget choicePricetype() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Đơn vị tính: ",
          style: TextStyle(fontSize: fontSize.medium),
        ),
        Wrap(
          spacing: 3,
          children: List.generate(
            priceTypes.length,
            (index) => ChoiceChip(
              selectedColor: colorProject.primaryColor.withOpacity(0.2),
              label: Text(priceTypes[index].name),
              selected: priceTypeChoice == index,
              onSelected: (value) {
                setState(() {
                  priceTypeChoice = index;
                  context
                      .read<SaveInfoLaundryCubit>()
                      .updatePriceType(priceTypes[index].code);
                  context.read<CalculateLaundryCubit>().calculateLaundry(
                      context.read<SaveInfoLaundryCubit>().state);
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
