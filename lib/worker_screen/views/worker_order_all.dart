import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/components/dialog_wrong.dart';
import 'package:rmservice/utilities/components/empty_card.dart';
import 'package:rmservice/utilities/components/text_field_basic.dart';
import 'package:rmservice/utilities/components/text_label.dart';
import 'package:rmservice/utilities/components/text_sub_label.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/worker_screen/constants/product.dart';
import 'package:rmservice/worker_screen/controllers/address_vn.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_cubit.dart';
import 'package:rmservice/worker_screen/cubits/get_order_all/get_order_all_state.dart';
import 'package:rmservice/worker_screen/models/address_vn.dart';
import 'package:rmservice/worker_screen/widgets/worker_order_card.dart';

class WorkerOrderAll extends StatefulWidget {
  const WorkerOrderAll({super.key});

  @override
  State<WorkerOrderAll> createState() => _WorkerOrderAllState();
}

class _WorkerOrderAllState extends State<WorkerOrderAll> {
  double distance = 5;
  final _scrollController = ScrollController();
  List<ProvinceVN> province = [];
  String? provinceId;
  String? provinceName;
  String? districtId;
  String? districtName;
  String? productType = "PRODUCT_CODE_UNSPECIFIED";
  int optionChoice = 0;
  List<String> options = [
    "Theo khoảng cách",
    "Theo tỉnh thành - quận huyện",
  ];

  @override
  void initState() {
    super.initState();
    context.read<WorkerGetOrderAllCubit>().reset();
    context.read<WorkerGetOrderAllCubit>().getOrderAll(
        context.read<UserCubit>().state.code!,
        distance: distance,
        city: provinceName,
        district: districtName,
        productCode: productType);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context.read<WorkerGetOrderAllCubit>().getOrderAll(
            context.read<UserCubit>().state.code!,
            distance: distance,
            city: provinceName,
            district: districtName,
            productCode: productType);
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
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    var workerGetOrderAll = context.watch<WorkerGetOrderAllCubit>();
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Bộ lọc đơn hàng",
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
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<WorkerGetOrderAllCubit>().reset();
                context.read<WorkerGetOrderAllCubit>().getOrderAll(
                    context.read<UserCubit>().state.code!,
                    distance: distance,
                    city: provinceName,
                    district: districtName,
                    productCode: productType);
              },
              child: workerGetOrderAll.state is WorkerGetOrderAllError
                  ? Center(child: Text("Đã có lỗi xảy ra"))
                  : SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      child: (workerGetOrderAll.orders.isEmpty &&
                              workerGetOrderAll.state
                                  is WorkerGetOrderAllLoaded)
                          ? WorkerEmptyOrder(
                              title: "Không có đơn gần đây",
                              desc:
                                  "Không có đơn gần đây. Vui lòng thay đổi địa chỉ mặc định")
                          : Column(
                              children: [
                                for (int i = 0;
                                    i < workerGetOrderAll.orders.length;
                                    i++)
                                  WorkerOrderCard(
                                      order: workerGetOrderAll.orders[i]),
                                //loading
                                BlocBuilder<WorkerGetOrderAllCubit,
                                        WorkerGetOrderAllState>(
                                    builder: (context, state) {
                                  if (state is WorkerGetOrderAllLoading) {
                                    return Align(
                                      alignment: FractionalOffset.topCenter,
                                      child: CircularProgressIndicator(
                                        color: colorProject.primaryColor,
                                      ),
                                    );
                                  }
                                  return Container();
                                }),
                              ],
                            ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

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
              child:
                  TextLabel(label: "Bộ lọc đơn hàng", isDarkMode: isDarkMode),
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
                        productType = "PRODUCT_CODE_UNSPECIFIED";
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
                              .firstWhere((element) => element.provinceId == value)
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
                              .firstWhere((element) => element.districtId == value)
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
            TextSubLabel(
                label: "Loại công việc",
                isDarkMode: isDarkMode,
                color: Colors.grey),
            SizedBox(height: 6),
            DropdownButton(
              isDense: true,
              isExpanded: true,
              hint: Text("Chọn loại công việc"),
              value: productType,
              items: productTypes.map((value) {
                return DropdownMenuItem(
                  value: value.code,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  productType = value!;
                  debugPrint("productType: $productType, value: $value");
                });
              },
            ),

            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ButtonGreenApp(
                label: "Đồng ý",
                onPressed: () {
                  if ((double.tryParse(controller.text) == null ||
                      double.tryParse(controller.text)! <= 0) && optionChoice == 0) {
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
                    context.read<WorkerGetOrderAllCubit>().reset();
                    context.read<WorkerGetOrderAllCubit>().getOrderAll(
                        context.read<UserCubit>().state.code!,
                        distance: distance,
                        city: provinceName,
                        district: districtName,
                        productCode: productType);
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
