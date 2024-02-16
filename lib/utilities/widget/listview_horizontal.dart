import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/air_conditioning_cleaning/cubit/get_price_air_cond/get_price_air_cond_cubit.dart';
import 'package:rmservice/air_conditioning_cleaning/views/air_conditioning_cleaning_page.dart';
import 'package:rmservice/cleaning_hourly/cubits/get_price_cleaning_hourly/get_price_cleaning_hourly_cubit.dart';
import 'package:rmservice/cleaning_hourly/views/cleaning_hourly_step1.dart';
import 'package:rmservice/cleaning_longterm/cleaning_longterm.dart';
import 'package:rmservice/cleaning_longterm/cubit/get_price/get_price_cleaning_longterm_cubit.dart';
import 'package:rmservice/cooking/cooking.dart';
import 'package:rmservice/cooking/cubit/get_price_cooking/get_price_cooking_cubit.dart';
import 'package:rmservice/laundry/cubits/get_price_laundry/get_price_laundry_cubit.dart';
import 'package:rmservice/laundry/views/laundry_step1.dart';
import 'package:rmservice/main_page/main_page.dart';
import 'package:rmservice/shopping/cubits/get_shopping_price/get_shopping_price_cubit.dart';
import 'package:rmservice/shopping/views/shopping_step2.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class HorizontalListViewWithIndicator extends StatefulWidget {
  const HorizontalListViewWithIndicator({super.key});

  @override
  _HorizontalListViewWithIndicatorState createState() =>
      _HorizontalListViewWithIndicatorState();
}

class _HorizontalListViewWithIndicatorState
    extends State<HorizontalListViewWithIndicator> {
  @override
  Widget build(BuildContext context) {
    // final List<Widget> items = [
    //   ServiceCard(
    //     icon: Icons.access_alarm,
    //     width: 50,
    //     text: AppLocalizations.of(context)!.hourly,
    //     //color: colorProject.primaryColor.withOpacity(0.65),
    //     onPressed: () {
    //       debugPrint('On pressed');
    //       //Route
    //       Navigator.push(
    //         context,
    //         PageTransition(
    //           type: PageTransitionType.rightToLeftWithFade,
    //           child: CleaningHourlyStep1Screen(),
    //           childCurrent: MainPage(),
    //         ),
    //       );
    //       context.read<GetPriceCleaningHourlyCubit>().getPriceCleaningHourly();
    //     },
    //   ),
    //   ServiceCard(
    //     icon: Icons.cleaning_services,
    //     width: 50,
    //     text: AppLocalizations.of(context)!.longTerm,
    //     //color: Color(0xff0e5bb0).withOpacity(0.65),
    //     onPressed: () {
    //       debugPrint('On pressed');
    //       //Route
    //       Navigator.push(
    //           context,
    //           PageTransition(
    //               type: PageTransitionType.rightToLeftWithFade,
    //               child: CleaningLongTermPage(),
    //               childCurrent: MainPage()));
    //       context
    //           .read<GetPriceCleaningLongtermCubit>()
    //           .getPriceCleaningLongTerm();
    //     },
    //   ),
    //   ServiceCard(
    //     icon: Icons.ac_unit_outlined,
    //     //color: Color(0xffFF9A00).withOpacity(0.65),
    //     width: 50,
    //     text: AppLocalizations.of(context)!.airConditioningCleaning,
    //     onPressed: () {
    //       debugPrint('On pressed');
    //       //Route
    //       Navigator.push(
    //         context,
    //         PageTransition(
    //           type: PageTransitionType.rightToLeftWithFade,
    //           child: AirConditioningCleaningPage(),
    //           childCurrent: MainPage(),
    //         ),
    //       );
    //       context.read<GetPriceAirCondCubit>().getPriceAirCond();
    //     },
    //   ),
    //   ServiceCard(
    //     icon: Icons.shopping_cart,
    //     width: 50,
    //     //color: Color(0xffFF5900).withOpacity(0.65),
    //     text: AppLocalizations.of(context)!.shopping,
    //     onPressed: () {
    //       debugPrint('On pressed Shopping');
    //       //Route
    //       Navigator.push(
    //         context,
    //         PageTransition(
    //           duration: Duration(milliseconds: 500),
    //           type: PageTransitionType.rightToLeftWithFade,
    //           child: ShoppingStep2Screen(),
    //           childCurrent: MainPage(),
    //         ),
    //       );
    //       context.read<GetShoppingPriceCubit>().getShoppingPrice();
    //     },
    //   ),
    //   ServiceCard(
    //     icon: Icons.local_laundry_service,
    //     width: 50,
    //     text: AppLocalizations.of(context)!.laundry,
    //     onPressed: () {
    //       debugPrint('On pressed Shopping');
    //       //Route
    //       Navigator.push(
    //         context,
    //         PageTransition(
    //           duration: Duration(milliseconds: 500),
    //           type: PageTransitionType.rightToLeftWithFade,
    //           child: LaundryStep1Screen(),
    //           childCurrent: MainPage(),
    //         ),
    //       );
    //       context.read<GetPriceLaundryCubit>().getPriceLaundry();
    //     },
    //   ),
    //   ServiceCard(
    //     icon: Icons.cookie,
    //     width: 50,
    //     text: AppLocalizations.of(context)!.cooking,
    //     onPressed: () {
    //       debugPrint('On pressed');
    //       //Route
    //       Navigator.push(
    //         context,
    //         PageTransition(
    //           type: PageTransitionType.rightToLeftWithFade,
    //           child: CookingPage(),
    //           childCurrent: MainPage(),
    //         ),
    //       );
    //       context.read<GetPriceCookingCubit>().getPriceCooking();
    //     },
    //   ),
    // ];
    // return Wrap(
    //   spacing: 60,
    //   runSpacing: 12,
    //   //alignment: WrapAlignment.spaceBetween,
    //   children: <Widget>[
    //     items[0],
    //     items[1],
    //     items[2],
    //     items[3],
    //     items[4],
    //     items[5],
    //   ],
    // );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
          // color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(200),
          // ),
          ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 50,
        mainAxisSpacing: 20,
        children: [
          itemDashboard('Giúp việc theo giờ',
              'assets/images/cleaning_hourly.png', Colors.deepOrange, () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: CleaningHourlyStep1Screen(),
                childCurrent: MainPage(),
              ),
            );
            context
                .read<GetPriceCleaningHourlyCubit>()
                .getPriceCleaningHourly();
          }),
          itemDashboard('Giúp việc theo gói',
              'assets/images/cleaning_longterm.png', Colors.green, () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: CleaningLongTermPage(),
                    childCurrent: MainPage()));
            context
                .read<GetPriceCleaningLongtermCubit>()
                .getPriceCleaningLongTerm();
          }),
          itemDashboard('Vệ sinh máy lạnh', 'assets/images/air_conditioner.png',
              Colors.purple, () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: AirConditioningCleaningPage(),
                childCurrent: MainPage(),
              ),
            );
            context.read<GetPriceAirCondCubit>().getPriceAirCond();
          }),
          itemDashboard('Đi chợ hộ', 'assets/images/shopping.png', Colors.brown,
              () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeftWithFade,
                child: ShoppingStep2Screen(),
                childCurrent: MainPage(),
              ),
            );
            context.read<GetShoppingPriceCubit>().getShoppingPrice();
          }),
          itemDashboard('Giặt ủi', 'assets/images/washing.png', Colors.indigo,
              () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeftWithFade,
                child: LaundryStep1Screen(),
                childCurrent: MainPage(),
              ),
            );
            context.read<GetPriceLaundryCubit>().getPriceLaundry();
          }),
          itemDashboard('Nấu ăn', 'assets/images/cooking.png', Colors.teal, () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: CookingPage(),
                childCurrent: MainPage(),
              ),
            );
            context.read<GetPriceCookingCubit>().getPriceCooking();
          }),
        ],
      ),
    );
  }

  itemDashboard(
          String title, String image, Color background, Function() onTap) =>
      InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    color: Theme.of(context).primaryColor.withOpacity(.25),
                    spreadRadius: 1,
                    blurRadius: 2)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: fontBoldApp,
                    fontSize: fontSize.textField,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
