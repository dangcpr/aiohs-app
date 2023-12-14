import 'package:rmservice/maid_near/models/maid_rating.dart';

class MaidRatingResult {
  late List<MaidRatingRes> listMaidRating;
  late String next;

  MaidRatingResult({
    required this.listMaidRating,
    required this.next
  });
}