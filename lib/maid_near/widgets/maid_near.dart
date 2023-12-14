import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/maid_near/controllers/get_maid_info.dart';
import 'package:rmservice/maid_near/models/maid_res.dart';
import 'package:rmservice/maid_near/widgets/maid_near_card.dart';
import 'package:rmservice/user_address/controllers/user_address.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MaidNear extends StatefulWidget {
  const MaidNear({super.key});

  @override
  State<MaidNear> createState() => _MaidNearState();
}

class _MaidNearState extends State<MaidNear> {
  List<AddressResponse> listAddress = [];
  List<MaidRes> listMaid = [];
  int loading = 0;
  String error = "";

  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  Future<void> getUserAddress() async {
    setState(() {
      loading = 1;
    });
    try {
      listAddress = await UserAddressController()
          .getAddress(context.read<UserCubit>().state.code!);
      if(listAddress.isNotEmpty) {
        // ignore: use_build_context_synchronously
        listMaid = await MaidInfoController().getMaidAround(context.read<UserCubit>().state.code!);
        debugPrint(jsonEncode(listMaid));
      }
      setState(() {
        loading = 0;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      //height: 150,
      width: double.infinity,
      child: loading == 2
          ? Text(error)
          : loading == 1
              ? Center(
                  child: CircularProgressIndicator(
                      color: colorProject.primaryColor))
              : Container(
                  child: listAddress.isEmpty
                      ? Text('Vui lòng lưu ít nhất 1 địa chỉ mặc định')
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < listMaid.length; i++)
                                MaidNearCard(maidNear: listMaid[i]),
                            ]
                          )
                      ),
                ),
    );
  }
}

class GetUserAddressState {}
