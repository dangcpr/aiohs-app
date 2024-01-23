import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/cleaning_hourly/views/maps.dart' as cleaning;
import 'package:rmservice/shopping/views/maps.dart' as shopping;
import 'package:rmservice/user_address/controllers/user_address.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/user_address/widgets/address_card.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class YourAddress extends StatefulWidget {
  const YourAddress({super.key, this.isShopping = false});

  final bool isShopping;

  @override
  State<YourAddress> createState() => _YourAddressState();
}

class _YourAddressState extends State<YourAddress> {
  List<AddressResponse> listAddress = [];
  int loading = 0;
  String error = "";
  @override
  void initState() {
    super.initState();
    getAddress();
  }

  Future<void> getAddress() async {
    var user = context.read<UserCubit>().state;
    loading = 1;
    try {
      listAddress = await UserAddressController().getAddress(user.code!);
      debugPrint(jsonEncode(listAddress));
      setState(() {
        loading = 0;
      });
    } catch (e) {
      error = e.toString();
      setState(() {
        loading = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Expanded(
            child: loading == 1
                ? Center(
                    child: CircularProgressIndicator(
                        color: colorProject.primaryColor),
                  )
                : loading == 2
                    ? Center(
                        child: Text(error),
                      )
                    : listAddress.isEmpty
                        ? Center(
                            child: Text("Không có địa chỉ"),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (int i = 0; i < listAddress.length; i++)
                                  AddressCard(address: listAddress[i], inUseCase: true),
                              ],
                            ),
                          ),
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ButtonGreenApp(
              label: "Chọn địa điểm khác",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 500),
                    child: widget.isShopping
                        ? shopping.ChooseLocationScreen()
                        : cleaning.ChooseLocationScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
