// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rmservice/chat/chat_page.dart';
import 'package:rmservice/chat/controller/chat_controller.dart';
import 'package:rmservice/login/cubit/user_cubit.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:rmservice/utilities/widget/see_maps.dart';
import 'package:rmservice/utilities/components/button_green.dart';

class PlaceContact extends StatefulWidget {
  const PlaceContact({super.key, required this.rentalPlace});

  final RentalPlaceRes rentalPlace;

  @override
  State<PlaceContact> createState() => _PlaceContactState();
}

class _PlaceContactState extends State<PlaceContact> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: ButtonGreenApp(
                label: "Liên hệ",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (builder) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "Mã người cho thuê: " +
                                          widget.rentalPlace.user_code,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: fontBoldApp),
                                    ),
                                    SizedBox(height: 10),
                                    ButtonGreenApp(
                                      label: "Chat với người cho thuê",
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Center(
                                            child: CircularProgressIndicator(
                                              color: colorProject.primaryColor,
                                            ),
                                          ),
                                        );
                                        try {
                                          var chatToken = await ChatController()
                                              .getChatToken(
                                                  requesterCode: context
                                                      .read<UserCubit>()
                                                      .state
                                                      .code
                                                      .toString(),
                                                  receiverCode: widget
                                                      .rentalPlace.user_code
                                                      .toString(),
                                                  title:
                                                      widget.rentalPlace.title,
                                                  postCode:
                                                      widget.rentalPlace.code);
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => ChatPage(
                                                      chatToken: chatToken)));
                                          print('chat token: $chatToken');
                                        } catch (e) {
                                          Navigator.pop(context);
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.bottomSlide,
                                            title: 'Có lỗi xảy ra',
                                            desc: e.toString(),
                                            btnOkOnPress: () {},
                                          ).show();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ButtonGreenApp(
                label: "Địa chỉ trên Google Maps",
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: SeeMapPlace(
                        latitude: widget.rentalPlace.latitude,
                        longtitude: widget.rentalPlace.longitude,
                        title: widget.rentalPlace.title,
                        address: widget.rentalPlace.address,
                      ),
                      type: PageTransitionType.rightToLeftWithFade,
                      duration: Duration(milliseconds: 400),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
