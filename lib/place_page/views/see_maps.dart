import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rmservice/cleaning_hourly/models/address.dart';
import 'package:rmservice/user_address/views/show_bottom_address.dart';
import 'package:rmservice/utilities/constants/mapsController.dart';
import 'package:rmservice/utilities/constants/variable.dart';

class SeeMapPlace extends StatefulWidget {
  const SeeMapPlace(
      {super.key,
      required this.latitude,
      required this.longtitude,
      required this.title,
      required this.address});

  final double latitude;
  final double longtitude;
  final String title;
  final String address;

  @override
  State<SeeMapPlace> createState() => _SeeMapPlaceState();
}

class _SeeMapPlaceState extends State<SeeMapPlace> {
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
    _center = LatLng(widget.latitude, widget.longtitude);
    markers = {
      Marker(
        markerId: MarkerId('Current Position'),
        position: _center,
        infoWindow: InfoWindow(
          title: widget.title,
          snippet: widget.address,
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
          'Cho thuê chỗ - Địa điểm',
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
