import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rmservice/maid_near/models/maid_rating.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class MaidRatingCard extends StatefulWidget {
  const MaidRatingCard({super.key, required this.maidRating});

  final MaidRatingRes maidRating;

  @override
  State<MaidRatingCard> createState() => _MaidRatingCardState();
}

class _MaidRatingCardState extends State<MaidRatingCard> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(5.5),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorProject.primaryColor.withOpacity(0.17),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/no_avatar.png'),
                  radius: 32.5,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.maidRating.renter_name,
                        style: TextStyle(
                            fontFamily: fontBoldApp,
                            fontSize: fontSize.medium + 1,
                            color: colorProject.primaryColor),
                      ),
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: widget.maidRating.star.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        onRatingUpdate: (rating) {
                          null;
                        },
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 255, 235, 59),
                          );
                        },
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: TextStyle(
                            fontFamily: fontApp,
                            fontSize: fontSize.medium,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Dịch vụ: ',
                              style: TextStyle(
                                fontFamily: fontBoldApp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.maidRating.product_name,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: TextStyle(
                            fontFamily: fontApp,
                            fontSize: fontSize.medium,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Nhận xét: ',
                              style: TextStyle(
                                fontFamily: fontBoldApp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.maidRating.comment,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
