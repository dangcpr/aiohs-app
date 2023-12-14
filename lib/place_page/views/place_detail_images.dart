import 'package:flutter/material.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:rmservice/place_page/models/rental_place_res.dart';

class PlaceDetailImages extends StatefulWidget {
  const PlaceDetailImages({super.key, required this.rentalPlace});

  final RentalPlaceRes rentalPlace;

  @override
  State<PlaceDetailImages> createState() => _PlaceDetailImagesState();
}

class _PlaceDetailImagesState extends State<PlaceDetailImages> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List<Widget>.generate(
          widget.rentalPlace.images.length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () => {
                  PopupBanner(
                    fit: BoxFit.fitWidth,
                    autoSlide: true,
                    context: context,
                    fromNetwork: true,
                    images: widget.rentalPlace.images,
                    onClick: (index) {
                      debugPrint("CLICKED $index");
                    },
                  ).show()
                },
                child: Image.network(
                  widget.rentalPlace.images[index],
                  width: size.width,
                  //fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
