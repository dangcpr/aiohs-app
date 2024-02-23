import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/place_page/cubits/get_place_public/get_place_public_cubit.dart';
import 'package:rmservice/place_page/cubits/get_place_public/get_place_public_state.dart';
import 'package:rmservice/place_page/widgets/place_card.dart';
import 'package:rmservice/shopping/widgets/dialog_wrong.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/text_sub_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';

import '../../utilities/components/empty_card.dart';
import '../../worker_screen/controllers/address_vn.dart';
import '../../worker_screen/models/address_vn.dart';

class PlacePublic extends StatefulWidget {
  const PlacePublic({super.key});

  @override
  State<PlacePublic> createState() => _PlacePublicState();
}

class _PlacePublicState extends State<PlacePublic> {
  double distance = 5;
  final ScrollController _scrollController = ScrollController();

  List<ProvinceVN> province = [];
  String? provinceId;
  String? provinceName;
  String? districtId;
  String? districtName;
  int optionChoice = 0;
  List<String> options = [
    "Theo khoảng cách",
    "Theo tỉnh thành - quận huyện",
  ];

  @override
  void initState() {
    super.initState();
    context.read<GetPlacePublicCubit>().setInit();
    context.read<GetPlacePublicCubit>().getPlacePublic(
          context.read<UserCubit>().state.code!,
          distance,
          provinceName,
          districtName,
        );
    debugPrint(
        context.read<GetPlacePublicCubit>().rentalPlace.length.toString());
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context.read<GetPlacePublicCubit>().setInit();
        context.read<GetPlacePublicCubit>().getPlacePublic(
              context.read<UserCubit>().state.code!,
              distance,
              provinceName,
              districtName,
            );
      }
    });
  }

  void getProvince() async {
    List<ProvinceVN> provinceTemp =
        await GetAddressVNController().getProvince();
    setState(() {
      province = provinceTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: BlocBuilder<GetPlacePublicCubit, GetPlacePublicState>(
          builder: (context, state) {
        if (state is GetPlacePublicLoading) {
          return Center(
            child: CircularProgressIndicator(color: colorProject.primaryColor),
          );
        }

        if (state is GetPlacePublicLoaded) {
          return RefreshIndicator(
            color: colorProject.primaryColor,
            onRefresh: () async {
              context.read<GetPlacePublicCubit>().setInit();
              await context.read<GetPlacePublicCubit>().getPlacePublic(
                    context.read<UserCubit>().state.code!,
                    distance,
                    provinceName,
                    districtName,
                  );
              debugPrint(state.rentalPlaceRes.length.toString());
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: state.rentalPlaceRes.isEmpty
                  ? WorkerEmptyOrder(
                      title: "Không có bài đăng nào!",
                      desc:
                          "Hiện không có bài đăng cho thuê chỗ, vui lòng quay lại sau!",
                    )
                  : Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      //controller: _scrollController,
                      //physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Bộ lọc tin thuê chỗ",
                              style: TextStyle(
                                  fontFamily: fontBoldApp,
                                  fontSize: fontSize.medium,
                                  color: colorProject.primaryColor),
                            ),
                            // Text(
                            //   distance.toString() + " km",
                            //   style: TextStyle(
                            //     fontFamily: fontBoldApp,
                            //     fontSize: fontSize.medium,
                            //   ),
                            // ),
                            SizedBox(width: 5),
                            InkWell(
                              child: Icon(
                                Icons.filter_list,
                                color: colorProject.primaryColor,
                                size: 30,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      content: StatefulBuilder(
                                        builder: (context, setState) {
                                          return filter(isDarkMode);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        SizedBox(height: 10),
                        LocationCard(
                            rentalPlace: state.rentalPlaceRes, isUser: false),
                        SizedBox(height: 10),
                      ],
                    ),
            ),
          );
        }
        if (state is GetPlacePublicError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return SizedBox();
        }
      }),
    );
  }

  // Widget changeDistance(bool isDarkMode) {
  //   TextEditingController controller = TextEditingController();
  //   controller.text = distance.toString();
  //   return Container(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         TextLabel(label: "Thay đổi khoảng cách", isDarkMode: isDarkMode),
  //         SizedBox(height: 20),
  //         TextFieldBasic(
  //           controller: controller,
  //           isDarkMode: isDarkMode,
  //           hintText: "Khoảng cách (km)",
  //         ),
  //         SizedBox(height: 20),
  //         ButtonGreenApp(
  //           label: "Đồng ý",
  //           onPressed: () {
  //             if (double.tryParse(controller.text) == null ||
  //                 double.tryParse(controller.text)! <= 0) {
  //               showDialog(
  //                 context: context,
  //                 builder: (context) {
  //                   return DialogWrong(
  //                     notification: "Khoảng cách phải là số và lớn hơn không",
  //                   );
  //                 },
  //               );
  //             } else {
  //               setState(() {
  //                 distance = double.tryParse(controller.text)!;
  //               });
  //               Navigator.pop(context);
  //               context.read<GetPlacePublicCubit>().setInit();
  //               context.read<GetPlacePublicCubit>().getPlacePublic(
  //                     context.read<UserCubit>().state.code!,
  //                     distance,
  //                     provinceName,
  //                     districtName,
  //                   );
  //             }
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget filter(bool isDarkMode) {
    TextEditingController controller = TextEditingController();
    controller.text = distance.toString();

    return StatefulBuilder(builder: (context, setState) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: TextLabel(
                  label: "Bộ lọc tin thuê chỗ", isDarkMode: isDarkMode),
            ),
            SizedBox(height: 10),
            // choice chip
            Align(
              child: Column(
                children: List<Widget>.generate(2, (index) {
                  return ChoiceChip(
                    selectedColor: colorProject.primaryColor.withOpacity(0.4),
                    label: Text(options[index]),
                    selected: optionChoice == index,
                    onSelected: (value) {
                      setState(() {
                        optionChoice = index;
                        controller.text = "0.0";
                        distance = 0;
                        provinceId = null;
                        provinceName = null;
                        districtId = null;
                        districtName = null;
                      });
                    },
                  );
                }),
              ),
            ),
            if (optionChoice == 0) SizedBox(height: 20),
            if (optionChoice == 0)
              TextFieldBasic(
                controller: controller,
                isDarkMode: isDarkMode,
                hintText: "Khoảng cách (km)",
                enabled: optionChoice == 0 ? true : false,
              ),
            // SizedBox(height: 20),
            // TextLabel(label: "Tỉnh/Thành phố", isDarkMode: isDarkMode),
            if (optionChoice == 1)
              TextSubLabel(
                  label: "Tỉnh/thành phố",
                  isDarkMode: isDarkMode,
                  color: Colors.grey),
            if (optionChoice == 1) SizedBox(height: 6),
            if (optionChoice == 1)
              FutureBuilder<List<ProvinceVN>>(
                future: GetAddressVNController().getProvince(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      isDense: true,
                      isExpanded: true,
                      hint: Text("Chọn tỉnh/thành phố"),
                      value: provinceId,
                      items: snapshot.data!.map((value) {
                        return DropdownMenuItem(
                          value: value.provinceId,
                          child: Text(value.provinceName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          provinceId = value!;
                          provinceName = snapshot.data!
                              .firstWhere(
                                  (element) => element.provinceId == value)
                              .provinceName;
                          debugPrint("provinceId: $provinceId, value: $value");
                          districtId = null;
                        });
                      },
                    );
                  }
                  return Text("Đang chờ ...");
                },
              ),
            //SizedBox(height: 20),
            if (provinceId != null && optionChoice == 1) SizedBox(height: 10),
            if (provinceId != null && optionChoice == 1)
              TextSubLabel(
                  label: "Quận/Huyện",
                  isDarkMode: isDarkMode,
                  color: Colors.grey),
            if (provinceId != null && optionChoice == 1) SizedBox(height: 6),
            if (provinceId != null && optionChoice == 1)
              FutureBuilder<List<DistrictVN>>(
                future: GetAddressVNController().getDistrict(provinceId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      isDense: true,
                      isExpanded: true,
                      hint: Text("Chọn quận/huyện"),
                      value: districtId,
                      items: snapshot.data!.map((value) {
                        return DropdownMenuItem(
                          value: value.districtId,
                          child: Text(value.districtName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          districtId = value!;
                          districtName = snapshot.data!
                              .firstWhere(
                                  (element) => element.districtId == value)
                              .districtName;
                          debugPrint("district: $provinceId, value: $value");
                        });
                      },
                    );
                  }
                  return Text("Đang chờ ...");
                },
              ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ButtonGreenApp(
                label: "Đồng ý",
                onPressed: () {
                  if ((double.tryParse(controller.text) == null ||
                          double.tryParse(controller.text)! <= 0) &&
                      optionChoice == 0) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogWrong(
                          notification:
                              "Khoảng cách phải là số và lớn hơn không",
                        );
                      },
                    );
                  } else {
                    setState(() {
                      distance = double.tryParse(controller.text)!;
                    });
                    Navigator.pop(context);
                    context.read<GetPlacePublicCubit>().setInit();
                    context.read<GetPlacePublicCubit>().getPlacePublic(
                          context.read<UserCubit>().state.code!,
                          distance,
                          provinceName,
                          districtName,
                        );
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
