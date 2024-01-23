import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class OptionCard extends StatefulWidget {
  const OptionCard(
      {super.key, required this.text, required this.icon, this.onTap, this.color = colorProject.primaryColor});

  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isDarkMode == true ? Colors.transparent : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDarkMode == true ? Colors.black : Colors.grey.shade300,
              blurRadius: 2.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ListTile(
          focusColor: Colors.grey,
          onTap: widget.onTap,
          leading: Icon(
            widget.icon,
            color: widget.color,
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: widget.color,
          ),
          title: Text(
            widget.text,
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.mediumLarger,
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
