import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/shopping/constants/function.dart';
import 'package:rmservice/shopping/constants/test_address.dart';
import 'package:rmservice/shopping/cubits/save_data.dart';
import 'package:rmservice/shopping/views/shopping_step1.dart';
import 'package:rmservice/shopping/views/shopping_step2.dart';
import 'package:rmservice/shopping/widgets/every_address.dart';

class ListAddress extends StatefulWidget {
  const ListAddress({super.key});

  @override
  State<ListAddress> createState() => _ListAddressState();
}

class _ListAddressState extends State<ListAddress> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Column(
      children: List<Widget>.generate(
        testAddress.length,
        (index) {
          return Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  debugPrint(index.toString() + " Shopping");
                  context.read<SaveDataShopping>().state.address =
                      testAddress[index];
                      
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 400),
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ShoppingStep2Screen(),
                      childCurrent: ShoppingStep1Screen(),
                    ),
                  );
                },
                child: EveryAddressShopping(
                  isDarkMode: isDarkMode,
                  nameAddress: testAddress[index].nameAddress!,
                  typeOfAddress: checkTypeOfAddress(
                      testAddress[index].typeOfAddress!, context),
                  yourName: testAddress[index].yourName!,
                  phoneNum: testAddress[index].phoneNum!,
                  fullAddress: testAddress[index].fullAddress!,
                ),
              ),
              SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}
