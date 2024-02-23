import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/place_page/cubits/get_place_user/get_place_user_cubit.dart';
import 'package:rmservice/place_page/cubits/get_place_user/get_place_user_state.dart';
import 'package:rmservice/place_page/views/create_rental_screen.dart';
import '../../utilities/components/empty_card.dart';
import '../widgets/place_card.dart';
import '../../utilities/constants/variable.dart';

class PlaceUser extends StatefulWidget {
  const PlaceUser({super.key});

  @override
  State<PlaceUser> createState() => _PlaceUserState();
}

class _PlaceUserState extends State<PlaceUser> {
  int? _value = 0;
  List<String> listStatus = ["Tin đang hoạt động", "Tin đã khóa"];

  @override
  void initState() {
    super.initState();
    context
        .read<GetPlaceUserCubit>()
        .getPlaceUser(context.read<UserCubit>().state.code!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colorProject.primaryColor,
        label: Text(
          "Bạn muốn cho thuê?",
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.medium,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: CreateRentalScreen(),
              type: PageTransitionType.rightToLeftWithFade,
              duration: Duration(milliseconds: 400),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 5.0,
              alignment: WrapAlignment.spaceBetween,
              children: List<Widget>.generate(
                listStatus.length,
                (int index) {
                  return ChoiceChip(
                    selectedColor: colorProject.primaryColor.withOpacity(0.4),
                    label: Text(listStatus[index]),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        if (_value == 1) {
                          _value = 0;
                          context.read<GetPlaceUserCubit>().getPlaceUser(
                                context.read<UserCubit>().state.code!,
                              );
                        } else {
                          _value = 1;
                          context
                              .read<GetPlaceUserCubit>()
                              .getPlaceUserInactive(
                                  context.read<UserCubit>().state.code!);
                        }
                      });
                    },
                  );
                },
              ).toList(),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<GetPlaceUserCubit, GetPlaceUserState>(
              builder: (context, state) {
                if (state is GetPlaceUserLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: colorProject.primaryColor),
                  );
                }

                if (state is GetPlaceUserLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<GetPlaceUserCubit>().setInit();
                      _value == 0
                          ? context.read<GetPlaceUserCubit>().getPlaceUser(
                                context.read<UserCubit>().state.code!,
                              )
                          : context
                              .read<GetPlaceUserCubit>()
                              .getPlaceUserInactive(
                                  context.read<UserCubit>().state.code!);
                    },
                    child: state.rentalPlaceRes.isEmpty
                        ? WorkerEmptyOrder(
                            title: "Không có bài đăng nào!",
                            desc: "Hiện không có bài đăng nào!",
                          )
                        : LocationCard(
                            rentalPlace: state.rentalPlaceRes,
                            isUser: true,
                          ),
                  );
                }

                if (state is GetPlaceUserError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
