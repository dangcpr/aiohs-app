import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  double distance = 5;
  double star = 3;

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

      if (listAddress.isNotEmpty) {
        // ignore: use_build_context_synchronously
        listMaid = await MaidInfoController().getMaidAround(
            context.read<UserCubit>().state.code!, distance, star);
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Người giúp việc gần đây",
                style: const TextStyle(
                  fontFamily: fontBoldApp,
                  fontSize: 20,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                filterMaidNear();
              },
              child: Row(
                children: const [
                  Icon(Icons.filter_list, color: colorProject.primaryColor),
                  SizedBox(width: 5),
                  Text(
                    "Lọc",
                    style: const TextStyle(
                      fontFamily: fontBoldApp,
                      fontSize: fontSize.medium,
                      color: colorProject.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
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
                                ],
                              ),
                            ),
                    ),
        ),
      ],
    );
  }

  void filterMaidNear() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          padding: const EdgeInsets.all(20),
          color: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Số sao trung bình',
                      style: TextStyle(
                        fontFamily: fontBoldApp,
                        fontSize: fontSize.mediumLarger,
                      ),
                    ),
                  ),
                  RatingBar.builder(
                    allowHalfRating: false,
                    itemSize: 25,
                    initialRating: star.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        star = rating;
                        getUserAddress();
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
