import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade200,
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
              color: Colors.white,
            ),
            child: DefaultTabController(
              length: 3,
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
                        Tab(text: "Liên hệ"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //Add this to give height
                      child: TabBarView(children: [
                        PlaceTabDetail(rentalPlace: widget.rentalPlace),
                        PlaceDetailImages(rentalPlace: widget.rentalPlace),
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
          ? FloatingActionButton.extended(
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
                    child: UpdateRentalScreen(rentalPlace: widget.rentalPlace),
                    type: PageTransitionType.rightToLeftWithFade,
                    duration: Duration(milliseconds: 400),
                  )
                );
              },
            )
          : null,
    );
  }
}
