// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/place_page/controllers/place_page.dart';
import 'package:rmservice/place_page/cubits/get_place_user/get_place_user_cubit.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/place_page/views/place_contact.dart';
import 'package:rmservice/place_page/views/place_detail_images.dart';
import 'package:rmservice/place_page/views/place_tab.dart';
import 'package:rmservice/place_page/views/update_rental_screen.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen(
      {super.key, required this.rentalPlace, this.isUser = false});

  final RentalPlaceRes rentalPlace;
  final bool isUser;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int length = widget.isUser == false ? 3 : 2;
    var userCubit = context.read<UserCubit>();
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: isDark ? Colors.grey[800] : Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      body: Column(
        children: [
          Image.network(
            widget.rentalPlace.images[0],
            height: size.height * 0.45,
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.55,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
            ),
            child: DefaultTabController(
              length: length,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      indicatorColor: colorProject.primaryColor,
                      labelStyle: TextStyle(
                        color: colorProject.primaryColor,
                        fontFamily: fontBoldApp,
                        fontSize: fontSize.medium,
                      ),
                      tabs: [
                        Tab(text: "Chi tiết"),
                        Tab(text: "Hình ảnh"),
                        if (widget.isUser == false) Tab(text: "Liên hệ"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //Add this to give height
                      child: TabBarView(children: [
                        PlaceTabDetail(rentalPlace: widget.rentalPlace),
                        PlaceDetailImages(rentalPlace: widget.rentalPlace),
                        if (widget.isUser == false)
                          PlaceContact(rentalPlace: widget.rentalPlace),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.isUser
          ? widget.rentalPlace.status == "inactive"
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      heroTag: null,
                      backgroundColor: colorProject.primaryColor,
                      label: Text(
                        "Khóa bài",
                        style: TextStyle(
                          fontFamily: fontBoldApp,
                          fontSize: fontSize.medium,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.topSlide,
                          title: "Bạn có chắc chắn khóa bài này?",
                          titleTextStyle: TextStyle(
                            fontFamily: fontBoldApp,
                            fontSize: fontSize.large,
                            color: Colors.yellow.shade700,
                          ),
                          desc:
                              "Bạn có chắc chắn khóa bài này, thao tác sẽ không thể hoàn tác?",
                          descTextStyle: TextStyle(
                            fontFamily: fontApp,
                            fontSize: fontSize.medium,
                          ),
                          btnCancelOnPress: () {
                            //Navigator.pop(context);
                          },
                          btnOkOnPress: () async {
                            //Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                });
                            try {
                              await PlacePageController().cancelRental(
                                  widget.rentalPlace, userCubit.state.code!);
                              context
                                  .read<GetPlaceUserCubit>()
                                  .getPlaceUser(userCubit.state.code!);
                              Navigator.pop(context);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.topSlide,
                                title: "Hủy tin thành công",
                              ).show();
                            } catch (e) {
                              Navigator.pop(context);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.topSlide,
                                title: "Có lỗi xảy ra",
                                titleTextStyle: TextStyle(
                                  fontFamily: fontBoldApp,
                                  fontSize: fontSize.large,
                                ),
                                desc: e.toString(),
                                descTextStyle: TextStyle(
                                  fontFamily: fontApp,
                                  fontSize: fontSize.medium,
                                ),
                              ).show();
                            }
                          },
                        ).show();
                      },
                    ),
                    SizedBox(height: 10),
                    FloatingActionButton.extended(
                      heroTag: null,
                      backgroundColor: colorProject.primaryColor,
                      label: Text(
                        "Chỉnh sửa bài",
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
                            child: UpdateRentalScreen(
                                rentalPlace: widget.rentalPlace),
                            type: PageTransitionType.rightToLeftWithFade,
                            duration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                    ),
                  ],
                )
          : null,
    );
  }
}
