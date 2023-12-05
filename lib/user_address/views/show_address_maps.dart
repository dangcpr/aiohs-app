import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rmservice/user_address/models/address_response.dart';
import 'package:rmservice/user_address/views/show_bottom_address.dart';
import 'package:rmservice/utilities/constants/mapsController.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class ShowAddressUser extends StatefulWidget {
  const ShowAddressUser({super.key, required this.address});

  final AddressResponse address;

  @override
  State<ShowAddressUser> createState() => _ShowAddressUserState();
}

class _ShowAddressUserState extends State<ShowAddressUser> {
  late GoogleMapController googleMapController;

  late LatLng _center;

  late Set<Marker> markers;

  //Position? _currentPosition;

  MapController mapController = MapController();

  late double latCurrent, lngCurrent;

  TextEditingController searchLocationController = TextEditingController();

  bool isSearch = false;

  Address addressObject = Address();

  bool isOnCameraMove = true;

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.address.latitude, widget.address.longitude);
    markers = {
      Marker(
        markerId: MarkerId('Current Position'),
        position: _center,
        infoWindow: InfoWindow(
          title: widget.address.detail,
          snippet: widget.address.street_name,
        ),
      )
    };
  }

  //dispose
  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    //controller.setMapStyle(Utils.mapStyles)
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Địa điểm đã lưu',
          style: TextStyle(
            fontFamily: fontBoldApp,
            fontSize: fontSize.mediumLarger,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (isSearch) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (builder) {
                    return BottomSheetAddressUser(isDarkMode: isDarkMode);
                  },
                );
              } else
                null;
            },
            child: Text(
              "Chọn",
              style: TextStyle(
                fontFamily: fontBoldApp,
                fontSize: fontSize.mediumLarger,
                color: isSearch ? colorProject.primaryColor : Colors.grey,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 17.0,
            ),
            onLongPress: (cameraPosition) {
              setState(() {
                isOnCameraMove = true;
              });
              debugPrint("On Long Press Map");
            },
            onCameraMove: (cameraPosition) {},
            onCameraIdle: () async {},
          ),
        ],
      ),
    );
  }
}
