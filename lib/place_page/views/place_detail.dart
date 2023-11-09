import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:rmservice/place_page/models/rental_place.dart';
import 'package:rmservice/place_page/widgets/info_line.dart';
import 'package:rmservice/utilities/components/button_green.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({super.key, required this.rentalPlace});

  final RentalPlace rentalPlace;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.asset(
            widget.rentalPlace.images[0],
            height: double.infinity,
            fit: BoxFit.none,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.85,
              snap: true,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    width: double.infinity,
                    height: size.height * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Divider(thickness: 5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.rentalPlace.titleRent,
                          style: TextStyle(
                            fontSize: fontSize.large,
                            fontWeight: FontWeight.bold,
                            fontFamily: fontBoldApp,
                          ),
                        ),
                        SizedBox(height: 8),
                        InfoLine(
                          title: 'Địa điểm cho thuê: ',
                          content: widget.rentalPlace.address,
                          icon: Icons.location_on,
                        ),
                        SizedBox(height: 8),
                        InfoLine(
                          title: 'Diện tích cho thuê: ',
                          content:
                              widget.rentalPlace.area.toString() + ' m\u00b2',
                          icon: Icons.square_foot,
                        ),
                        SizedBox(height: 8),
                        InfoLine(
                          title: 'Chi tiết: ',
                          content: widget.rentalPlace.description,
                          icon: Icons.info_outline,
                        ),
                        SizedBox(height: 8),
                        InfoLine(
                          title: 'Giá cho thuê: ',
                          content: NumberFormat.simpleCurrency(
                                  locale: 'vi-VN', decimalDigits: 0)
                              .format(widget.rentalPlace.price),
                          icon: Icons.attach_money,
                        ),
                        SizedBox(height: 8),
                        InfoLine(
                          title: 'Số ngày cho thuê: ',
                          content: widget.rentalPlace.numOfDayRent.toString() +
                              ' ngày',
                          icon: Icons.timer,
                        ),
                        SizedBox(height: 8),
                        InfoLine(
                          title: 'Hình ảnh chỗ thuê: ',
                          icon: Icons.image,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List<Widget>.generate(
                              widget.rentalPlace.images.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: () => {
                                      PopupBanner(
                                        context: context,
                                        images: widget.rentalPlace.images,
                                        fromNetwork: false,
                                        onClick: (index) {
                                          debugPrint("CLICKED $index");
                                        },
                                      ).show()
                                    },
                                    child: Image.asset(
                                      widget.rentalPlace.images[index],
                                      width: size.width / 3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
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
                                      //height: size.height / 3,
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 20,
                                          bottom: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InfoLine(
                                            title: 'Họ và tên: ',
                                            content: widget.rentalPlace.name,
                                            icon: Icons.person,
                                          ),
                                          SizedBox(height: 8),
                                          InfoLine(
                                            title: 'Số điện thoại: ',
                                            content: widget.rentalPlace.phone
                                                .toString(),
                                            icon: Icons.phone,
                                          ),
                                          SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            child: ButtonGreenApp(
                                              label: "Chat với người cho thuê",
                                              onPressed: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        // InfoLine(
                        //   content: widget.rentalPlace.

                        // )
                      ],
                    ),
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
