import 'package:rmservice/place_page/models/rental_place_res.dart';

class RentalPlaceResult {
  final String next;
  final List<RentalPlaceRes> rentalPlaceRes;

  RentalPlaceResult({
    required this.next,
    required this.rentalPlaceRes
  });
}