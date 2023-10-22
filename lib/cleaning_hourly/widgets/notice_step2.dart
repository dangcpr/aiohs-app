import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class NoticeStep2 extends StatefulWidget {
  const NoticeStep2({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<NoticeStep2> createState() => _NoticeStep2State();
}

class _NoticeStep2State extends State<NoticeStep2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: TextStyle(fontSize: fontSize.medium),
        ),
        SizedBox(width: 8),
        Flexible(
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.0,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
              children: const <TextSpan>[
                TextSpan(
                  text: 'Lưu ý: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: fontBoldApp,
                  ),
                ),
                TextSpan(
                  text:
                      'nếu bạn lựa chọn giờ buổi tối (từ 18:00 đến 08:00 sáng hôm sau) và chọn ngày làm việc ngày nghỉ (thứ 7, chủ nhật hoặc ngày lễ) sẽ bị phụ thu thêm.',
                  style: TextStyle(
                    fontFamily: fontApp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
