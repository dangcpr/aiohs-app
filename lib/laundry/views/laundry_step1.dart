import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/cleaning_hourly/cubits/save_info/save_address.dart';
import 'package:rmservice/cleaning_hourly/views/maps.dart';
import 'package:rmservice/cleaning_hourly/widgets/button_app_bar.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_cubit.dart';
import 'package:rmservice/get_product/cubits/get_product/get_product_state.dart';
import 'package:rmservice/get_product/models/product.dart';
import 'package:rmservice/laundry/helpers/set_price_laundry.dart';
import 'package:rmservice/laundry/widgets/button/button_next_step1.dart';
import 'package:rmservice/laundry/widgets/card/dry_cleaning_card.dart';
import 'package:rmservice/laundry/widgets/card/normal_cleaning_card.dart';
import 'package:rmservice/laundry/widgets/card/service_cleaning_card.dart';
import 'package:rmservice/utilities/components/text_label.dart';

class LaundryStep1Screen extends StatefulWidget {
  const LaundryStep1Screen({super.key});

  @override
  State<LaundryStep1Screen> createState() => _LaundryStep1ScreenState();
}

class _LaundryStep1ScreenState extends State<LaundryStep1Screen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    Product product;

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
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<GetProductCubit, GetProductState>(
        builder: (context, state) {
          if (state is GetProductLoaded) {
            product = state.products
                .firstWhere((element) => element.code == 'LAUNDRY');
            setPriceLaundry(product, context);

            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 90),
              child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: [
                  TextLabel(
                    label: "Vui lòng chọn những thứ bạn muốn giặt ủi",
                    isDarkMode: isDarkMode,
                  ),
                  SizedBox(height: 10),
                  NormalCleaningCard(),
                  SizedBox(height: 10),
                  DryCleaningCard(),
                  SizedBox(height: 10),
                  ServiceCleaningCard(),
                  
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: ButtonNextStep1Laundry(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    )
    ;
  }
}
