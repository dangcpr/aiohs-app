import 'package:flutter/material.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ShowInfoAddress extends StatefulWidget {
  const ShowInfoAddress({super.key, required this.address});

  final AddressResponse address;

  @override
  State<ShowInfoAddress> createState() => _ShowInfoAddressState();
}

class _ShowInfoAddressState extends State<ShowInfoAddress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Thông tin địa điểm",
            style: TextStyle(
              fontFamily: fontBoldApp,
              fontSize: fontSize.large,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.person, color: colorProject.primaryColor, size: 30),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget.address.agent_name,
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone, color: colorProject.primaryColor, size: 30),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget.address.agent_phone,
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.add_location_sharp, color: colorProject.primaryColor, size: 30),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget.address.type == "home"
                      ? "Nhà riêng"
                      : widget.address.type == "office"
                          ? "Văn phòng"
                          : "Nhà riêng",
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                widget.address.type == "home"
                    ? Icons.home
                    : (widget.address.type == "office"
                        ? Icons.work
                        : Icons.apartment),
                color: colorProject.primaryColor,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget.address.detail + " - " + widget.address.street_name,
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontSize: fontSize.mediumLarger,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
