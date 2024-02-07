import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';
import 'package:rmservice/place_page/widgets/info_line.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class PlaceTabDetail extends StatefulWidget {
  const PlaceTabDetail({super.key, required this.rentalPlace});

  final RentalPlaceRes rentalPlace;

  @override
  State<PlaceTabDetail> createState() => _PlaceTabDetailState();
}

class _PlaceTabDetailState extends State<PlaceTabDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.rentalPlace.title,
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
              content: widget.rentalPlace.area.toString() + ' m\u00b2',
              icon: Icons.square_foot,
            ),
            SizedBox(height: 8),
            InfoLine(
              title: 'Chiều cao phòng: ',
              content: widget.rentalPlace.height.toString() + ' m',
              icon: Icons.height,
            ),
            SizedBox(height: 8),
            InfoLine(
              title: 'Thang máy: ',
              content: widget.rentalPlace.has_elevator ? 'Có' : 'Không',
              icon: Icons.elevator,
            ),
            SizedBox(height: 8),
            InfoLine(
              title: 'Nơi cho thuê ở trên lầu: ',
              content: widget.rentalPlace.on_the_floors ? 'Có' : 'Không',
              icon: Icons.house_siding,
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
              content:
                  NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                      .format(widget.rentalPlace.price),
              icon: Icons.attach_money,
            ),
            SizedBox(height: 8),
            InfoLine(
              title: 'Số ngày cho thuê: ',
              content:
                  widget.rentalPlace.number_rental_days.toString() + ' ngày',
              icon: Icons.timer,
            ),
            SizedBox(height: 8),
            SizedBox(height: 15),
            // InfoLine(
            //   content: widget.rentalPlace.

            // )
          ],
        ),
      ),
    );
  }
}
