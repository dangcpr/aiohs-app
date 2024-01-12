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

class PlacePublic extends StatefulWidget {
  const PlacePublic({super.key});

  @override
  State<PlacePublic> createState() => _PlacePublicState();
}

class _PlacePublicState extends State<PlacePublic> {
  double distance = 5;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<GetPlacePublicCubit>().setInit();
    context
        .read<GetPlacePublicCubit>()
        .getPlacePublic(context.read<UserCubit>().state.code!, 5, distance);
    debugPrint(
        context.read<GetPlacePublicCubit>().rentalPlace.length.toString());
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        //the bottom of the scrollbar is reached
        //adding more widgets
        context.read<GetPlacePublicCubit>().setInit();
        context
            .read<GetPlacePublicCubit>()
            .getPlacePublic(context.read<UserCubit>().state.code!, 5, distance);
      }
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
            onRefresh: () async {
              context.read<GetPlacePublicCubit>().setInit();
              await context.read<GetPlacePublicCubit>().getPlacePublic(
                    context.read<UserCubit>().state.code!,
                    5,
                    distance,
                  );
              debugPrint(state.rentalPlaceRes.length.toString());
            },
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //controller: _scrollController,
                //physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextSubLabel(
                        label: "Bạn muốn tìm chỗ thuê trong khoảng: ",
                        isDarkMode: isDarkMode,
                      ),
                      Text(
                        distance.toString() + " km",
                        style: TextStyle(
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.medium,
                        ),
                      ),
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
                                content: changeDistance(isDarkMode),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(child: LocationCard(
                      rentalPlace: state.rentalPlaceRes, isUser: false)),
                  SizedBox(height: 10),
                ],
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

  Widget changeDistance(bool isDarkMode) {
    TextEditingController controller = TextEditingController();
    controller.text = distance.toString();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextLabel(label: "Thay đổi khoảng cách", isDarkMode: isDarkMode),
          SizedBox(height: 20),
          TextFieldBasic(
            controller: controller,
            isDarkMode: isDarkMode,
            hintText: "Khoảng cách (km)",
          ),
          SizedBox(height: 20),
          ButtonGreenApp(
            label: "Đồng ý",
            onPressed: () {
              if (double.tryParse(controller.text) == null ||
                  double.tryParse(controller.text)! <= 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogWrong(
                      notification: "Khoảng cách phải là số và lớn hơn không",
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
                    context.read<UserCubit>().state.code!, 5, distance);
              }
            },
          )
        ],
      ),
    );
  }
}
